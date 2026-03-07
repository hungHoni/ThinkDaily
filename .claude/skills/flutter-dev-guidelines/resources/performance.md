# Performance — Optimization & Profiling

## const Widgets — Most Impactful Change

Mark every widget `const` when its constructor args are compile-time constants.
Flutter skips diffing `const` widgets entirely.

```dart
// ALWAYS const when possible
const SizedBox(height: 16)          // ✅
const Padding(padding: EdgeInsets.all(16), child: ...)  // ✅
const Text('Static Label')          // ✅
const Icon(Icons.home)              // ✅

// Can't be const — dynamic data
Text(user.name)                     // no const (runtime value)
SizedBox(height: dynamicHeight)     // no const
```

Enable lint rule to catch missing `const`:
```yaml
# analysis_options.yaml
linter:
  rules:
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    prefer_const_declarations: true
```

---

## Riverpod — Preventing Unnecessary Rebuilds

### select — watch only the field you need

```dart
// BAD — rebuilds when ANY user field changes
final user = ref.watch(userNotifierProvider).valueOrNull;
Text(user?.name ?? '')

// GOOD — only rebuilds when name changes
final name = ref.watch(
  userNotifierProvider.select((s) => s.valueOrNull?.name),
);
Text(name ?? '')
```

### Consumer — isolate rebuild scope

```dart
class ProductScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This section does NOT rebuild when cart changes
    final product = ref.watch(productProvider(id));

    return Column(
      children: [
        ProductInfo(product: product),    // rebuilds with product
        Consumer(                          // ONLY this rebuilds with cart
          builder: (_, ref, __) {
            final inCart = ref.watch(cartContainsProvider(id));
            return AddToCartButton(inCart: inCart);
          },
        ),
      ],
    );
  }
}
```

---

## ListView — Always Builder for Dynamic Lists

```dart
// BAD — builds all items at once, no recycling
Column(
  children: orders.map((o) => OrderCard(order: o)).toList(), // ❌
)

// GOOD — only builds visible items, recycles off-screen
ListView.builder(
  itemCount: orders.length,
  itemBuilder: (context, i) => OrderCard(order: orders[i]),  // ✅
)

// For mixed content (header + list)
CustomScrollView(
  slivers: [
    SliverToBoxAdapter(child: HeaderWidget()),
    SliverList.builder(
      itemCount: items.length,
      itemBuilder: (_, i) => ItemCard(item: items[i]),
    ),
  ],
)
```

---

## Image Optimization

```dart
// CachedNetworkImage with proper sizing
CachedNetworkImage(
  imageUrl: url,
  // Resize to display size — don't load 4K for a 50px avatar
  memCacheWidth: 100,
  memCacheHeight: 100,
  maxWidthDiskCache: 300,
  maxHeightDiskCache: 300,
  fit: BoxFit.cover,
  fadeInDuration: 150.ms,
  placeholder: (_, __) => const SkeletonAvatar(),
  errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
)

// For local assets — pre-cache on app start
await precacheImage(const AssetImage('assets/images/hero.png'), context);
```

---

## Lazy Loading / Pagination

```dart
// Detect when user scrolls near bottom
class OrderListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ordersPaginatedNotifierProvider);
    final orders = state.valueOrNull?.items ?? [];
    final hasMore = state.valueOrNull?.hasMore ?? false;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter < 200 &&
            hasMore &&
            !state.isLoading) {
          ref.read(ordersPaginatedNotifierProvider.notifier).loadMore();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: orders.length + (hasMore ? 1 : 0),
        itemBuilder: (_, i) {
          if (i == orders.length) return const LoadingWidget();
          return OrderCard(order: orders[i]);
        },
      ),
    );
  }
}
```

---

## Build Method — Keep It Pure

```dart
// BAD — business logic in build()
@override
Widget build(BuildContext context, WidgetRef ref) {
  final orders = ref.watch(ordersNotifierProvider).valueOrNull ?? [];
  final total = orders.fold(0.0, (sum, o) => sum + o.total); // ❌ computed in build
  final filtered = orders.where((o) => o.status == 'pending').toList(); // ❌
  return Text('${filtered.length} pending, \$$total total');
}

// GOOD — use derived providers
@riverpod
double ordersTotal(OrdersTotalRef ref) {
  final orders = ref.watch(ordersNotifierProvider).valueOrNull ?? [];
  return orders.fold(0.0, (sum, o) => sum + o.total);
}

@riverpod
List<Order> pendingOrders(PendingOrdersRef ref) {
  return ref.watch(ordersNotifierProvider)
      .valueOrNull
      ?.where((o) => o.status == OrderStatus.pending)
      .toList() ?? [];
}

@override
Widget build(BuildContext context, WidgetRef ref) {
  final total = ref.watch(ordersTotalProvider);
  final pending = ref.watch(pendingOrdersProvider);
  return Text('${pending.length} pending, \$$total total'); // ✅
}
```

---

## RepaintBoundary — Isolate Expensive Widgets

```dart
// Wrap expensive independently-updating widgets
RepaintBoundary(
  child: AnimatedChart(data: chartData),
)

RepaintBoundary(
  child: VideoPlayer(controller: controller),
)
```

---

## Avoid Rebuilding the Widget Tree on Navigator Changes

Use `AutomaticKeepAliveClientMixin` for tab screens you don't want rebuilt:

```dart
class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});
  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // required
    return const HomeScreen();
  }
}
```

With `StatefulShellRoute.indexedStack` in GoRouter, this is handled automatically.

---

## Memory Leaks — Common Causes

```dart
// 1. Not disposing controllers
class _MyState extends State<MyWidget> {
  final controller = TextEditingController();  // ❌ if not disposed

  @override
  void dispose() {
    controller.dispose();  // ✅ always dispose
    super.dispose();
  }
}

// 2. Stream subscriptions not cancelled
StreamSubscription? _sub;
_sub = stream.listen((_) { });

@override
void dispose() {
  _sub?.cancel();  // ✅
  super.dispose();
}

// 3. Riverpod: auto-dispose handles this for providers
// keepAlive: false (default) = disposes when all listeners leave ✅
```

---

## Profiling Checklist

Before shipping a screen:

```bash
# Run in profile mode (not debug — has no overhead from asserts)
flutter run --profile

# Then in DevTools:
# 1. Performance tab → record → interact → look for jank (frames > 16ms)
# 2. Widget Rebuild Stats → see which widgets rebuild most
# 3. Memory tab → check for leaks (heap growth over time)
```

Common jank causes:
- Building too many widgets per frame → extract + const
- Expensive `build()` computation → move to derived providers
- Images loaded at full resolution → add `memCacheWidth`/`memCacheHeight`
- `BoxDecoration` with `borderRadius` + `clipBehavior` → use `ClipRRect` carefully
- Too many `Container` wrappers → replace with direct `Padding`/`DecoratedBox`
