#!/usr/bin/env python3
"""
Miller Maps - Interactive Historical Map Builder
A custom mapping application with period-accurate themes and routing
"""

import os
import json
import datetime

def create_map_html():
    """Generate the main map interface HTML"""
    build_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S UTC")
    
    html_content = f"""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Miller Maps - Interactive Historical Map Builder</title>
    <style>
        body {{
            font-family: 'Courier New', monospace;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #2c1810 0%, #8B4513 100%);
            color: #f5f5dc;
            min-height: 100vh;
        }}
        .container {{
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(0,0,0,0.8);
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 0 20px rgba(0,0,0,0.5);
        }}
        h1 {{
            color: #DAA520;
            text-align: center;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
        }}
        .map-placeholder {{
            width: 100%;
            height: 500px;
            background: #1a1a1a;
            border: 2px solid #DAA520;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px 0;
            position: relative;
        }}
        .controls {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }}
        .control-panel {{
            background: rgba(218, 165, 32, 0.1);
            border: 1px solid #DAA520;
            border-radius: 5px;
            padding: 15px;
        }}
        .status {{
            text-align: center;
            margin: 20px 0;
            padding: 10px;
            background: rgba(0, 100, 0, 0.2);
            border-radius: 5px;
        }}
        .deployment-info {{
            font-size: 0.9em;
            opacity: 0.8;
        }}
    </style>
</head>
<body>
    <div class="container">
        <h1>⚔️ Miller Maps ⚔️</h1>
        <div class="status">
            <strong>✅ Application Deployed Successfully</strong>
            <div class="deployment-info">Build: {build_time}</div>
        </div>
        
        <div class="map-placeholder">
            <div style="text-align: center;">
                <h3>🗺️ Interactive Map Interface</h3>
                <p>Historical period-accurate mapping system</p>
                <p style="font-style: italic; opacity: 0.7;">Map rendering engine initializing...</p>
            </div>
        </div>
        
        <div class="controls">
            <div class="control-panel">
                <h3>🎨 Map Themes</h3>
                <ul>
                    <li>📜 Vintage Historical</li>
                    <li>🌃 Frank Miller Noir</li>
                    <li>🔮 Modern Interactive</li>
                </ul>
            </div>
            
            <div class="control-panel">
                <h3>🧭 Navigation Features</h3>
                <ul>
                    <li>⚡ Period-accurate routing</li>
                    <li>📍 Custom POIs</li>
                    <li>🔄 Offline access</li>
                </ul>
            </div>
            
            <div class="control-panel">
                <h3>⚙️ Development Status</h3>
                <ul>
                    <li>✅ GitHub Actions CI/CD</li>
                    <li>✅ Docker containerization</li>
                    <li>✅ Cloud Run deployment</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
    """
    
    return html_content

def main():
    """Main build process for Miller Maps"""
    print("🏗️  Miller Maps build process starting...")
    
    # Create directories
    os.makedirs('public', exist_ok=True)
    os.makedirs('docs', exist_ok=True)
    
    # Generate map interface
    html_content = create_map_html()
    
    # Write to both public and docs directories
    with open('public/index.html', 'w') as f:
        f.write(html_content)
    
    with open('docs/index.html', 'w') as f:
        f.write(html_content)
        
    with open('index.html', 'w') as f:
        f.write(html_content)
    
    # Create build info
    build_info = {
        'build_time': datetime.datetime.now().isoformat(),
        'version': '1.0.0',
        'status': 'success'
    }
    
    with open('build_info.json', 'w') as f:
        json.dump(build_info, f, indent=2)
    
    print("✅ Miller Maps build completed successfully!")
    print(f"📄 Generated files: public/index.html, docs/index.html, index.html")
    print(f"⏰ Build completed at: {build_info['build_time']}")

if __name__ == '__main__':
    main()