# Survey Definition Schema

Surveys are data-driven and should live in `_data/surveys/*.yml`.

## Root fields
- `id` (string, required): stable survey identifier.
- `title` (string, required): visible survey title.
- `description` (string, optional): supporting text.
- `voicePrompts` (boolean, optional): enable ResponsiveVoice prompts.
- `questions` (array, required): ordered question definitions.

## Question fields
- `id` (string, required): unique key used for responses.
- `type` (enum, required): `text`, `multiple_choice`, `rating`, `checkbox`.
- `label` (string, required): question prompt text.
- `required` (boolean, optional): marks required questions.
- `options` (array<string>, required for `multiple_choice` and `checkbox`).
- `condition` (object, optional): declarative visibility rules.

## Condition fields
- `dependsOn` (string): question `id` to evaluate.
- `operator` (enum): `equals`, `not_equals`, `includes`, `not_includes`.
- `value` (string): expected comparison value.
