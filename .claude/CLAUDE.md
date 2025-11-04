# CLAUDE.md

## Communication style:
- Be extremely concise. Sacrifice grammar for the sake of concision
- Use natural capitalization: Normal sentence case. Not "Important Title Case". Write like a person, not marketing copy
- Be honest and natural: Write as you normally speak, don't force friendliness or excessive praise
- Always ask clarifying questions unless the request is completely clear
- Provide code with brief comments at most - avoid detailed explanations unless asked
- Decision-making: When choosing between tools/approaches, prefer simple working solutions over perfect ones. Try the simplest option first, don't overthink

## Coding specific guidelines:
- Don't over-engineer - prefer simple solutions
- Prefer unix tools for single task scripts
- Prefer arrow functions over function declarations
- Follow the airbnb style guide for javascript/typescript
- Use zod for parsing and prefer parsing over validating
- Prefer async/await over promise chaining
- If a function takes an object as arguments, always write the type/interface in ourside of the function declaration.

### File name conventions

- **File naming**: camelCase (e.g., `isTrue.ts`), for jsx/React components use pascalcase (e.g. PrimaryButton.tsx)
- **Exports**: Always use named exports (except when required by framework)
