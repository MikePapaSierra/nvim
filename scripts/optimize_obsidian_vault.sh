#!/bin/bash

# ╭─────────────────────────────────────────────────────────────────────────────╮
# │ Obsidian Vault Organization & Optimization Script                          │
# │ Optimizes your personalObsidianVault structure for enhanced productivity   │
# ╰─────────────────────────────────────────────────────────────────────────────╯

VAULT_PATH="/home/mps/Documents/personalObsidianVault"

echo "🚀 Optimizing Obsidian Vault Structure..."

# Create organized directory structure if missing
echo "📁 Creating organized directory structure..."

# Core domains (already exist, but ensure proper permissions)
mkdir -p "$VAULT_PATH/00-daily"
mkdir -p "$VAULT_PATH/01-private"
mkdir -p "$VAULT_PATH/02-professional"
mkdir -p "$VAULT_PATH/03-hobby"

# Enhanced subdirectory organization
mkdir -p "$VAULT_PATH/02-professional/cloud-security"
mkdir -p "$VAULT_PATH/02-professional/certifications"
mkdir -p "$VAULT_PATH/02-professional/projects"
mkdir -p "$VAULT_PATH/02-professional/learning"

mkdir -p "$VAULT_PATH/03-hobby/woodworking"
mkdir -p "$VAULT_PATH/03-hobby/3d-printing"
mkdir -p "$VAULT_PATH/03-hobby/electronics"
mkdir -p "$VAULT_PATH/03-hobby/home-automation"

# Assets organization
mkdir -p "$VAULT_PATH/assets/images"
mkdir -p "$VAULT_PATH/assets/attachments"
mkdir -p "$VAULT_PATH/assets/documents"

# Archive and organization
mkdir -p "$VAULT_PATH/archive"
mkdir -p "$VAULT_PATH/archive/2024"
mkdir -p "$VAULT_PATH/archive/old-notes"

echo "✅ Directory structure optimized!"

# Create enhanced index files
echo "📋 Creating enhanced index files..."

# Main Dashboard
cat > "$VAULT_PATH/Dashboard.md" << 'EOF'
# 🏠 Personal Knowledge Dashboard

> **Your central hub for all domains: Personal • Professional • Hobby**

---

## 🚀 Quick Access

### 📅 Daily Operations
- [[dailies/{{date:YYYY-MM-DD}}|Today's Daily Note]]
- [[tasks|📋 Task Dashboard]]
- [[inbox|📥 Inbox]]

### 🎯 Domain Dashboards
- [[01-private/Private Dashboard|🏠 Personal Dashboard]]
- [[02-professional/Professional Dashboard|💼 Professional Dashboard]]
- [[03-hobby/Hobby Dashboard|🎨 Hobby Dashboard]]

---

## 📊 Recent Activity

### 📝 Recent Notes
```dataview
LIST
FROM ""
WHERE file.mtime >= date(today) - dur(7 days)
SORT file.mtime DESC
LIMIT 10
```

### ✅ Recent Tasks
```dataview
TASK
WHERE !completed
SORT file.mtime DESC
LIMIT 5
```

---

## 🔗 Navigation

| Section | Quick Links |
|---------|-------------|
| **Templates** | [[templates/TPL_Daily\|Daily]] • [[templates/TPL_Professional\|Professional]] • [[templates/TPL_Hobby_Project\|Hobby]] |
| **Reference** | [[TagGlossary\|Tags]] • [[Work links\|Work Links]] |
| **Archives** | [[archive\|Archive]] • [[OldNotesToSegregate\|Old Notes]] |

---

#dashboard #hub
EOF

# Professional Dashboard
cat > "$VAULT_PATH/02-professional/Professional Dashboard.md" << 'EOF'
# 💼 Professional Dashboard
## Cloud Security Engineering Hub

---

## 🎯 Current Focus Areas

### 🛡️ Security Projects
```dataview
LIST
FROM "02-professional/projects"
WHERE !completed
SORT priority DESC
```

### ☁️ Cloud Infrastructure
- [[02-professional/cloud-security|Cloud Security Notes]]
- [[AWS Security Maturity Model v2]]

### 📚 Learning Path
- [[02-professional/certifications|Certification Tracker]]
- [[02-professional/learning|Learning Notes]]

---

## 🔗 Quick Links
- [[Work links|Work Resources]]
- [[SCP|Service Control Policies]]
- [[IMDSv1|IMDS Security]]

---

#professional #dashboard #cloud-security
EOF

# Hobby Dashboard
cat > "$VAULT_PATH/03-hobby/Hobby Dashboard.md" << 'EOF'
# 🎨 Hobby Dashboard
## Creative & Technical Projects Hub

---

## 🚀 Active Projects

### 🪵 Woodworking
```dataview
LIST
FROM "03-hobby/woodworking"
WHERE status = "active"
```

### 🔧 3D Printing
```dataview
LIST  
FROM "03-hobby/3d-printing"
WHERE status = "active"
```

### 🏠 Home Automation
```dataview
LIST
FROM "03-hobby/home-automation" 
WHERE status = "active"
```

---

## 💡 Project Ideas
- [[03-hobby/project-ideas|💭 Future Projects]]
- [[03-hobby/inspiration|🎨 Inspiration Board]]

---

#hobby #dashboard #projects
EOF

echo "✅ Enhanced dashboards created!"

# Fix permissions
echo "🔒 Setting proper permissions..."
chmod -R u+rw "$VAULT_PATH"
find "$VAULT_PATH" -type d -exec chmod 755 {} \;

echo "🎉 Vault optimization complete!"
echo ""
echo "📋 Summary:"
echo "✅ Organized directory structure"
echo "✅ Enhanced dashboards created"
echo "✅ Proper permissions set"
echo ""
echo "🚀 Your vault is now optimized for enhanced productivity!"
