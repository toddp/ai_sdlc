# Git Submodule Setup for Shared SDLC

Use this setup to share `standards/` and `templates/` across multiple projects.

## 1. Initial Setup
Add the shared SDLC repository as a submodule in a hidden `.sdlc` directory.

```bash
# In project root
git submodule add git@github.com:your-org/cubiq-sdlc.git .sdlc
git submodule update --init --recursive
```

## 2. Create Symlinks
Link the shared folders into your local `docs/` structure so the Agent can find them at the expected paths.

```bash
cd docs
# Remove existing folders if they exist
rm -rf standards templates

# Link to submodule
ln -s ../.sdlc/standards standards
ln -s ../.sdlc/templates templates

# Optional: Link shared scripts
cd ..
ln -s .sdlc/scripts/quality_gate.sh scripts/quality_gate.sh
```

*Note: Verify symlinks with `ls -la docs/`.*

## 3. Cloning a Project
When cloning a repository that uses submodules, use the `--recursive` flag.

```bash
git clone --recursive git@github.com:your-org/your-project.git
```

If you already cloned without recursive:
```bash
git submodule update --init --recursive
```

## 4. Updating SDLC
To pull the latest changes from the shared SDLC repository:

```bash
# Update submodule to latest commit on remote branch
git submodule update --remote

# Commit the version bump in your project
git add .sdlc
git commit -m "Bump SDLC version"
```
