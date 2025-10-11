# ⚔️ Miller Maps - Interactive Historical Map Builder

A custom mapping application featuring interactive, high-resolution maps with historical themes, period-accurate borders, and efficient routing capabilities.

## 🎯 Features

- **Interactive Maps**: High-resolution indoor/outdoor mapping
- **Historical Themes**: Period-accurate borders and styling
- **Custom POIs**: AI-designed, themed location markers 
- **Offline Access**: Full functionality without connectivity
- **Multiple Themes**: 
  - 📜 Vintage Historical
  - 🌃 Frank Miller Noir 
  - 🔮 Modern Interactive
- **Smart Routing**: Efficient, accessible path finding

## 🚀 Quick Start

### Prerequisites
- Python 3.11+
- Docker Desktop (for local development)
- GitHub CLI (for log management)

### Local Development

```bash
# Clone the repository
git clone https://github.com/Butterdime/MILLER-MAP.git
cd MILLER-MAP

# Install dependencies
pip install -r requirements.txt

# Build and run locally
python3 main.py
python3 -m http.server 8080
```

### Docker Development

```bash
# Build container
docker build -t miller-maps .

# Run locally
docker run -p 8080:8080 miller-maps
```

## 🏗️ Deployment

### GitHub Pages
Automatically deploys on push to `main` branch via `.github/workflows/deploy.yml`

**Live Demo**: https://butterdime.github.io/MILLER-MAP/

### Google Cloud Run  
Dual deployment system with automatic containerization via `.github/workflows/cloud-run.yml`

**Production URL**: Available after Cloud Run deployment

## 🔍 Monitoring & Troubleshooting

### Log Management
Use the provided script to download GitHub Actions logs:

```bash
# Make script executable (first time only)
chmod +x download_logs.sh

# Download logs for a specific run
./download_logs.sh -r RUN_ID -o logs/

# Example
./download_logs.sh -r 18407369667 -o logs/
```

### Pre-flight Validation
Always start from a fresh terminal session after code changes:

```bash
# Open new terminal tab/window
# Navigate to project
cd /path/to/MILLER-MAP

# Validate before push
python3 main.py
```

### Workflow Status
- ✅ **CI Pipeline**: `.github/workflows/ci.yml`
- ✅ **Pages Deploy**: `.github/workflows/deploy.yml` 
- ✅ **Cloud Run Deploy**: `.github/workflows/cloud-run.yml`
- ✅ **Log Retrieval**: `download_logs.sh`

## 🔧 Development Workflow

### PDCA Cycle Implementation
1. **Plan**: Define objectives and validate requirements
2. **Do**: Implement changes with pre-flight validation
3. **Check**: Monitor via GitHub Actions and download logs
4. **Act**: Refine based on deployment feedback

### Best Practices
- Always start from new terminal after code changes
- Run `python3 main.py` before committing
- Use `download_logs.sh` for workflow debugging
- Review deployment status in GitHub Actions tab

## 🔐 Required Secrets (for Cloud Run)

Add these to your GitHub repository secrets:

- `GCP_PROJECT_ID`: Your Google Cloud Project ID
- `GCP_SA_KEY`: Service Account JSON key with Cloud Run permissions

## 📊 Project Structure

```
MILLER-MAP/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       ├── deploy.yml
│       └── cloud-run.yml
├── docs/           # GitHub Pages output
├── public/         # Build output
├── main.py         # Build script
├── app.py          # Application entry
├── Dockerfile      # Container definition
├── download_logs.sh # Log retrieval utility
└── requirements.txt # Python dependencies
```

## 🎯 Current Status

**Last Updated**: {update_time}
**Build Status**: ✅ Operational 
**Deployment**: Multi-platform (Pages + Cloud Run)
**Monitoring**: Automated via GitHub Actions

---

*Built with 💪 Hybrid Lean-Agile + Human-in-the-Loop MLOps methodology*
*Following PDCA cycles for continuous improvement*

🔗 **Quick Links**: [GitHub Actions](https://github.com/Butterdime/MILLER-MAP/actions) | [Issues](https://github.com/Butterdime/MILLER-MAP/issues) | [Deployments](https://github.com/Butterdime/MILLER-MAP/deployments)
""".format(update_time=datetime.datetime.now().strftime("%Y-%m-%d %H:%M UTC"))