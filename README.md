# IDH Simple - Identity Helper

A lightweight bash script that displays comprehensive user identity information in a clean, organized format with visual indicators.

## 🚀 Features

- **User Identity Overview**: Display username, UID, primary group, and security status
- **Group Membership**: Show all groups with their corresponding GIDs
- **Security Indicators**: Visual warnings for root user privileges
- **Flexible Usage**: Check current user or specify any system user
- **Clean Formatting**: Emoji-enhanced output for better readability
- **Group-Only Mode**: Option to display only group membership information

## 📦 Installation

```bash
# Download the script
wget https://raw.githubusercontent.com/stefan-hacks/idh/main/idh.sh

# Make it executable
chmod +x idh.sh

# Optionally, move to system PATH
sudo mv idh.sh /usr/local/bin/idh
```

## 🛠️ Usage

### Basic Usage
```bash
# Show current user identity
./idh.sh

# Show specific user identity
./idh.sh username
```

### Options
```bash
# Show help
./idh.sh --help

# Show only group membership
./idh.sh --groups

# Show groups for specific user
./idh.sh --groups username

# Explicit user information display
./idh.sh --user username
```

## 📋 Sample Output

```
==================================================
🔐 User Identity Information
==================================================
👤 Username        : john
🆔 User ID         : 1001
👥 Primary Group   : developers (1001)
--------------------------------------------------
📂 Groups          :
  adm                 (GID: 4)
  developers          (GID: 1001)
  docker              (GID: 132)
  sudo                (GID: 27)
--------------------------------------------------
🏠 Home Directory  : /home/john
🐚 Shell           : /bin/bash
--------------------------------------------------
🔒 Security Status : ✅ Regular User
==================================================
```

## 🎯 Use Cases

- **System Administration**: Quick user identity verification
- **Troubleshooting**: Debug permission and access issues
- **Security Audits**: Identify privileged users and group memberships
- **User Management**: Verify user configurations and shell assignments

## 🔧 Requirements

- Bash shell
- Standard Unix utilities (`id`, `getent`, `cut`, `sort`)

## 📄 License

MIT License - feel free to use and modify as needed.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

---

**Version**: 2.3.0  
**Author**: stefan-hacks
