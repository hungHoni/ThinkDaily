import * as fs from 'fs';
import * as path from 'path';
import * as readline from 'readline';

interface SkillRule {
  type: string;
  enforcement: string;
  priority: string;
  promptTriggers?: {
    keywords?: string[];
    intentPatterns?: string[];
  };
}

interface SkillRules {
  skills: Record<string, SkillRule>;
}

async function readStdin(): Promise<string> {
  const rl = readline.createInterface({ input: process.stdin });
  const lines: string[] = [];
  for await (const line of rl) {
    lines.push(line);
  }
  return lines.join('\n');
}

async function main() {
  const input = await readStdin();
  let prompt = '';

  try {
    const parsed = JSON.parse(input);
    prompt = parsed.prompt || parsed.message || input;
  } catch {
    prompt = input;
  }

  const promptLower = prompt.toLowerCase();
  const projectDir = process.env.CLAUDE_PROJECT_DIR || process.cwd();
  const rulesPath = path.join(projectDir, '.claude', 'skills', 'skill-rules.json');

  if (!fs.existsSync(rulesPath)) {
    process.exit(0);
  }

  const rules: SkillRules = JSON.parse(fs.readFileSync(rulesPath, 'utf8'));
  const matched: string[] = [];

  for (const [skillName, rule] of Object.entries(rules.skills)) {
    const triggers = rule.promptTriggers;
    if (!triggers) continue;

    let hit = false;

    if (triggers.keywords) {
      for (const kw of triggers.keywords) {
        if (promptLower.includes(kw.toLowerCase())) {
          hit = true;
          break;
        }
      }
    }

    if (!hit && triggers.intentPatterns) {
      for (const pattern of triggers.intentPatterns) {
        if (new RegExp(pattern, 'i').test(prompt)) {
          hit = true;
          break;
        }
      }
    }

    if (hit) matched.push(skillName);
  }

  if (matched.length === 0) {
    process.exit(0);
  }

  const banner = [
    '',
    '\u2501'.repeat(39),
    '\uD83C\uDFAF SKILL ACTIVATION CHECK',
    '\u2501'.repeat(39),
    '',
    '\uD83D\uDCDA RECOMMENDED SKILLS:',
    ...matched.map(s => `  \u2192 ${s}`),
    '',
    'ACTION: Use Skill tool BEFORE responding',
    '\u2501'.repeat(39),
    '',
  ].join('\n');

  process.stdout.write(banner);
  process.exit(0);
}

main().catch(() => process.exit(0));
