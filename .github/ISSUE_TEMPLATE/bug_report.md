---
name: Bug Report
about: Report a bug or unexpected behavior in the FastPix Ruby SDK
title: '[BUG] '
labels: ['bug', 'needs-triage']
assignees: ''
---

# Bug Report

Thank you for taking the time to report a bug with the FastPix Ruby SDK. To help us resolve your issue quickly and efficiently, please provide the following information:

## Description
**Clear and concise description of the bug:**
```
<!-- Please provide a detailed description of what you're experiencing -->
```

## Environment Information

### System Details
- **Ruby Version:** [e.g., 3.2, 3.3, 3.4]
- **Operating System:** [e.g., Windows 10, macOS 12.0, Ubuntu 20.04, etc.]
- **Package Manager:** [e.g., Bundler, gem]

### SDK Information
- **FastPix Ruby SDK Version:** [e.g., 1.0.3, 1.0.2, etc.]
- **Bundler Version:** [e.g., 2.4, 2.5, etc.]

## Reproduction Steps

1. **Setup Environment:**
   ```bash
   gem install fastpix-ruby
   # or
   bundle add fastpix-ruby
   ```

2. **Code to Reproduce:**
   ```ruby
   # Please provide a minimal, reproducible example
   require 'fastpix'

   fastpix = FastpixSDK.new(
     security: {
       username: 'your-username',
       password: 'your-password'
     }
   )

   # Your code here that causes the issue
   ```

3. **Expected Behavior:**

    ```
    <!-- Describe what you expected to happen -->
    ```

4. **Actual Behavior:**

    ```
    <!-- Describe what actually happened -->
    ```

5. **Error Messages/Logs:**
   ```
   <!-- Paste any error messages, stack traces, or logs here -->
   ```

## Debugging Information

### Console Output
```
<!-- Paste the complete console output here -->
```

### Error Stack Traces
```ruby
# Complete stack trace for Ruby errors
Traceback (most recent call last):
    1: from /path/to/your/file.rb:45:in `<main>'
/path/to/fastpix/file.rb:123:in `some_method': Error message (RuntimeError)
```

### HTTP Requests
```http
# Raw HTTP request (remove sensitive headers and credentials)
POST /api/endpoint HTTP/1.1
Host: [FastPix API endpoint]
Authorization: Basic ***
Content-Type: application/json

<!-- Remove credentials and sensitive headers before pasting -->
```

### Screenshots
```
<!-- If applicable, please attach screenshots that help explain your issue -->
```

## Additional Context

### Configuration
```ruby
# Please share your SDK configuration (remove sensitive information)
require 'fastpix'

fastpix = FastpixSDK.new(
  security: {
    username: '***',  # Redacted
    password: '***'  # Redacted
  },
  # Any other configuration options
)
```

### Workarounds
```
<!-- If you've found any workarounds, please describe them here -->
```

## Priority
Please indicate the priority of this bug:

- [ ] Critical (Blocks production use)
- [ ] High (Significant impact on functionality)
- [ ] Medium (Minor impact)
- [ ] Low (Nice to have)

## Checklist
Before submitting, please ensure:

- [ ] I have searched existing issues to avoid duplicates
- [ ] I have provided all required information
- [ ] I have tested with the latest SDK version
- [ ] I have removed any sensitive information (credentials, API keys, etc.)
- [ ] I have provided a minimal reproduction case
- [ ] I have checked the documentation

---

**Thank you for helping improve the FastPix Ruby SDK! 🚀**

