#!/bin/bash

# Tạo cấu trúc thư mục
mkdir -p docs/{overview,setup,deployment,automation,maintenance}
mkdir -p scripts config website/{content,layouts,static}

# Tạo các file trong thư mục docs
touch docs/overview/{general-process.md,technical-overview.md}
touch docs/setup/{development-environment.md,gcp-setup.md}
touch docs/deployment/{hugo-deployment.md,ssl-setup.md}
touch docs/automation/{cloud-build-config.md,monitoring-setup.md}
touch docs/maintenance/{update-procedures.md,version-control.md}

# Tạo các file trong thư mục scripts và config
touch scripts/{create-new-site.py,auto-deploy.sh}
touch config/{cloudbuild.yaml,dashboard.json}

# Tạo file config.toml cho Hugo
touch website/config.toml

# Tạo các file gốc
touch .gitignore README.md LICENSE

# Thêm nội dung vào README.md
echo "# Hugo Project Template

This is a template for Hugo projects with automated deployment to Google Cloud Platform.

## Structure

- \`docs/\`: Documentation files
- \`scripts/\`: Automation scripts
- \`config/\`: Configuration files
- \`website/\`: Hugo website source

## Getting Started

[Add instructions here]

## Deployment

[Add deployment instructions here]

## Maintenance

[Add maintenance instructions here]

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
" > README.md

# Thêm nội dung vào .gitignore
echo "# Hugo
public/
resources/

# OS Files
.DS_Store
Thumbs.db

# IDE/Editor folders
.vscode/
.idea/

# Dependency directories
node_modules/

# Build output
dist/
build/

# Logs
*.log

# Environment variables
.env
" > .gitignore

# Thêm License MIT
echo "MIT License

Copyright (c) 2024 Luong Pham Huy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the \"Software\"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
" > LICENSE

echo "Project structure created successfully!"
