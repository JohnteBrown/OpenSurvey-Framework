![codecov](https://codecov.io/gh/johntebrown/OpenSurvey-Framework/graph/badge.svg?token=9fd4cd33-1efd-4611-917e-5397e1275582)

# OpenSurvey Framework

A Data-driven survey runtime built with Jekyll + CoffeeScript + Backbone + JSViews. with api coming soon))

## Demo

here is the [demo](https://johntebrown.github.io/OpenSurvey-Framework/) of OpenSurvey Framework, perfect for integrating with a Headless CMS, **Read-Aloud is disabled on the demo**

## Run

1. Use the project Ruby version (`3.2.x`):
   - `rbenv install -s 3.2.4 && rbenv local 3.2.4`
   - or set `3.2.4` via your `asdf` Ruby plugin

---

> [!IMPORTANT]
> Ignore this step if you're not on Darwin.

2. Ensure Xcode command line tools are installed:
   - `xcode-select --install`

---

3. Install Ruby gems:

   - `bundle install`
4. Install Node dependencies:

   - `npm install`
5. Build frontend assets:

   - `npm run build`
     - `npm run build:dev` (dev)

   6. Serve Jekyll:

      - `npm run serve`

Open `http://127.0.0.1:4000/`.

## Testing & Coverage

- `npm test`
- `npm run test:coverage`

## Survey Content

- Edit survey definitions in `_data/surveys/*.yml`.
- Sample schema details are in `docs/survey-schema.md`.

## Notes

- The export copy utility uses a local `CopyPoisonService` adapter to keep the framework modular since the external `copypoison` package is unavailable on npm.
- If `bundle install` fails building `eventmachine` on Darwin, verify you are not using Ruby 4.x for this project. `jekyll` and transitive native gems are currently more reliable on Ruby `3.2.x`.
