# HashiCorp Certified: Terraform Authoring & Operations Professional Exam Guide

![GitHub last commit](https://img.shields.io/github/last-commit/ooluwgb/HashiCorp-Terraform-Professional-Prep)
![GitHub repo size](https://img.shields.io/github/repo-size/ooluwgb/HashiCorp-Terraform-Professional-Prep)
![GitHub](https://img.shields.io/github/license/ooluwgb/HashiCorp-Terraform-Professional-Prep)

> A comprehensive, hands-on study guide with detailed notes, practical code examples, and exercises to help you prepare for and pass the **HashiCorp Certified: Terraform Authoring & Operations Professional** exam.

---

## 📜 Table of Contents

- [📖 About This Project](#-about-this-project)
- [✨ What's Inside](#-whats-inside)
- [🚀 How to Use This Repository](#-how-to-use-this-repository)
- [📋 Prerequisites](#-prerequisites)
- [🏗️ Repository Structure](#️-repository-structure)
  - [Part 0: Introduction](#part-0-introduction)
  - [Part 1: Terraform Core Concepts](#part-1-terraform-core-concepts)
  - [Part 2: Advanced Terraform](#part-2-advanced-terraform)
  - [Part 3: Modules and Workflows](#part-3-modules-and-workflows)
  - [Part 4: Exam Preparation](#part-4-exam-preparation)
- [📚 Study Tips](#-study-tips)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

---

## 📖 About This Project

This repository serves as a **complete, structured study guide** for the HashiCorp Certified: Terraform Authoring & Operations Professional exam. Whether you're new to Terraform or looking to validate your expertise, this guide provides:

- **In-depth explanatory notes** covering all exam objectives
- **Practical, tested code examples** demonstrating real-world scenarios
- **Hands-on exercises** to reinforce learning and build muscle memory
- **Practice exams** to assess your readiness

The content is organized progressively, from core concepts to advanced topics, making it ideal for both systematic study and quick reference.

---

## ✨ What's Inside

- **10+ comprehensive sections** covering the complete exam syllabus
- **100+ working Terraform examples** with detailed explanations
- **Hands-on exercises** with solutions to test your understanding
- **AWS resource reference** for quick lookup during practice
- **Practice exam questions** aligned with the official exam format
- **Best practices** and common pitfall warnings throughout

---

## 🚀 How to Use This Repository

To maximize your learning, follow this recommended workflow:

### 1. **📝 Start with the Notes**
Each section contains a `notes.md` file with detailed explanations:
- Read through the concepts thoroughly
- Pay attention to the **Key Points** and **Important Notes** callouts
- Review the syntax and usage patterns

### 2. **💻 Study the Code Examples**
Navigate to the `examples` directory in each section:
- Examine how concepts are implemented in real Terraform code
- Try running the examples in your own AWS environment
- Modify the examples to experiment with different configurations

### 3. **✅ Complete the Exercises**
Work through the `exercises` directory for each part:
- Attempt the exercises without looking at solutions first
- Verify your solutions against the provided answers
- Troubleshoot any errors you encounter (this builds crucial debugging skills)

### 4. **🔄 Practice and Review**
- Use the practice exams in Part 4 to test your knowledge
- Revisit sections where you feel less confident
- Create your own mini-projects combining multiple concepts

**💡 Pro Tip:** Keep notes on concepts you find challenging and review them regularly.

---

## 📋 Prerequisites

Before diving in, ensure you have:

### Required Software
- **Terraform:** Version **1.13.3 or higher** (recommended: latest stable version)
  - 📥 Download from the [official Terraform website](https://www.terraform.io/downloads.html)
  - Verify installation: `terraform version`

- **AWS Account:** A free-tier account is sufficient for most examples
  - 🔐 Set up IAM credentials with appropriate permissions
  - 💳 Be mindful of potential costs (most examples use free-tier resources)

- **AWS CLI:** Configured with your credentials
  - 📥 Install from [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  - Configure: `aws configure`

### Recommended Knowledge
- Basic understanding of infrastructure concepts (networks, servers, storage)
- Familiarity with command-line interfaces
- Basic understanding of AWS services (EC2, S3, IAM)

### Optional Tools
- **Git:** For cloning and version control
- **VSCode with Terraform extension:** For enhanced code editing
- **terraform-docs:** For generating documentation

---

## 🏗️ Repository Structure

This repository is organized into 4 main parts, each containing multiple sections with `notes.md`, `examples`, and `exercises`.

### [Part 0: Introduction](./Part_0_Introduction)

**Focus:** Essential AWS resources used throughout the guide

| Section | Topics Covered |
|:--------|:---------------|
| [**Section 0: AWS Resources**](./Part_0_Introduction/SECTION_0_Aws_Resources) | Quick reference for AWS resources (EC2, S3, IAM, VPC, etc.) used in examples |
| [**Examples**](./Part_0_Introduction/examples) | Introductory code examples |

---

### [Part 1: Terraform Core Concepts](./Part_1_Terraform_Core_Concepts)

**Focus:** Fundamental Terraform concepts and workflows

| Section | Topics Covered |
|:--------|:---------------|
| [**Section 1: Introduction to Terraform**](./Part_1_Terraform_Core_Concepts/SECTION_1_Introduction_to_Terraform) | Installation, Configuration, Versioning, Providers, Initialization |
| [**Section 2: Interacting with Terraform**](./Part_1_Terraform_Core_Concepts/SECTION_2_Interacting_with_Terraform) | Provider blocks, `terraform plan`, `terraform apply`, `terraform destroy` |
| [**Section 3: Terraform Language Basics**](./Part_1_Terraform_Core_Concepts/SECTION_3_Terraform_Language_Basics) | Resources, Variables, Locals, Outputs, Data types |
| [**Examples**](./Part_1_Terraform_Core_Concepts/examples) | Foundational code examples |
| [**Exercises**](./Part_1_Terraform_Core_Concepts/exercises) | Practice exercises for Part 1 |

---

### [Part 2: Advanced Terraform](./Part_2_Advanced_Terraform)

**Focus:** Advanced features and state management

| Section | Topics Covered |
|:--------|:---------------|
| [**Section 4: State and Language**](./Part_2_Advanced_Terraform/SECTION_4_State_and_Language) | Backend configuration, Meta-arguments (`count`, `for_each`), Data blocks, `import`, `moved`, `removed` blocks |
| [**Section 5: Dynamic Configurations**](./Part_2_Advanced_Terraform/SECTION_5_Dynamic_Configurations) | Complex data types, Built-in functions, Variable validation, Dynamic blocks, Check blocks |
| [**Examples**](./Part_2_Advanced_Terraform/examples) | Advanced implementation examples |
| [**Exercises**](./Part_2_Advanced_Terraform/exercises) | Advanced practice exercises |

---

### [Part 3: Modules and Workflows](./Part_3_Modules_and_Workflows)

**Focus:** Modular design, testing, and team workflows

| Section | Topics Covered |
|:--------|:---------------|
| [**Section 6: Terraform Modules**](./Part_3_Modules_and_Workflows/SECTION_6_Terraform_Modules) | Module structure, Module variables & outputs, Publishing modules, Module import/moved blocks |
| [**Section 7: Static Analysis and Testing**](./Part_3_Modules_and_Workflows/SECTION_7_Static_Analysis_and_Testing) | `terraform validate`, `terraform fmt`, Testing frameworks, Policy as Code, HCP Terraform integration |
| [**Section 8: Advanced Commands & Remote State**](./Part_3_Modules_and_Workflows/SECTION_8_Advanced_Commands_and_Remote_State) | Advanced CLI commands, Sensitive data handling, Remote state backends, Terraform Enterprise/Cloud |
| [**Examples**](./Part_3_Modules_and_Workflows/examples) | Module and workflow examples |
| [**Exercises**](./Part_3_Modules_and_Workflows/exercises) | Real-world scenario exercises |

---

### [Part 4: Exam Preparation](./Part_4_Exam_Preparation)

**Focus:** Final preparation and practice exams

| Section | Topics Covered |
|:--------|:---------------|
| [**Section 9: AWS Resources Deep Dive**](./Part_4_Exam_Preparation/SECTION_9_AWS_Resources) | Detailed review of AWS resources commonly tested in the exam |
| [**Section 10: Practice Exams**](./Part_4_Exam_Preparation/SECTION_10_Practice_Exams) | Full-length practice exams with detailed explanations |
| [**Examples**](./Part_4_Exam_Preparation/examples) | Exam-style code examples |
| [**Exercises**](./Part_4_Exam_Preparation/exercises) | Exam simulation exercises |

---

## 📚 Study Tips

### For First-Time Learners
1. **Follow the order:** Start from Part 0 and progress sequentially
2. **Practice regularly:** Aim for 30-60 minutes daily rather than cramming
3. **Type, don't copy:** Manually type code examples to build muscle memory
4. **Break and rebuild:** Intentionally break examples to understand error messages

### For Exam Preparation
1. **Review exam objectives:** Cross-reference with [official exam review guide](https://www.hashicorp.com/certification/terraform-associate)
2. **Time yourself:** Practice completing tasks within time constraints
3. **Focus on weak areas:** Use practice exam results to identify gaps
4. **Understand 'why':** Don't just memorize—understand the reasoning behind each concept

### Common Pitfalls to Avoid
- ⚠️ Skipping the exercises (hands-on practice is crucial!)
- ⚠️ Not cleaning up AWS resources after practice
- ⚠️ Memorizing without understanding underlying concepts
- ⚠️ Ignoring state file management best practices

---

## 🤝 Contributing

Contributions are welcome and appreciated! Here's how you can help:

### Ways to Contribute
- 🐛 **Report bugs or errors** in notes or code
- 💡 **Suggest improvements** to explanations or examples
- ✏️ **Fix typos** or enhance documentation
- 📝 **Add new examples** or alternative approaches
- ❓ **Improve exercises** or add new practice questions

### Contribution Process
1. Fork this repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Make your changes with clear, descriptive commits
4. Test any code changes thoroughly
5. Submit a pull request with a detailed description

**Note:** Please ensure all code examples are tested and follow Terraform best practices.

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](./LICENSE) file for full details.

### What This Means
- ✅ Free to use for personal or commercial purposes
- ✅ Free to modify and distribute
- ✅ No warranty provided
- ℹ️ Attribution appreciated but not required

---

## 🌟 Acknowledgments

- HashiCorp for creating Terraform and maintaining comprehensive documentation
- The Terraform community for shared knowledge and best practices
- All contributors who help improve this study guide

---

## 📞 Support

- **Issues:** Open an issue for bugs or questions
- **Discussions:** Use GitHub Discussions for general questions
- **Updates:** Watch this repository for updates and improvements

---

**Good luck with your certification journey! 🚀**

*Remember: Consistent practice and hands-on experience are the keys to success.*
