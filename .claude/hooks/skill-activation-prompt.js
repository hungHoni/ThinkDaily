"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
const fs = __importStar(require("fs"));
const path = __importStar(require("path"));
const readline = __importStar(require("readline"));
async function readStdin() {
    const rl = readline.createInterface({ input: process.stdin });
    const lines = [];
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
    }
    catch {
        prompt = input;
    }
    const promptLower = prompt.toLowerCase();
    const projectDir = process.env.CLAUDE_PROJECT_DIR || process.cwd();
    const rulesPath = path.join(projectDir, '.claude', 'skills', 'skill-rules.json');
    if (!fs.existsSync(rulesPath)) {
        process.exit(0);
    }
    const rules = JSON.parse(fs.readFileSync(rulesPath, 'utf8'));
    const matched = [];
    for (const [skillName, rule] of Object.entries(rules.skills)) {
        const triggers = rule.promptTriggers;
        if (!triggers)
            continue;
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
        if (hit)
            matched.push(skillName);
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
