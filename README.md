# HashiCorp Certified: Terraform Authoring & Operations Professional Exam Guide

![GitHub last commit](https://img.shields.io/github/last-commit/ooluwgb/HashiCorp-Terraform-Professional-Prep)
![GitHub repo size](https://img.shields.io/github/repo-size/ooluwgb/HashiCorp-Terraform-Professional-Prep)
![GitHub](https://img.shields.io/github/license/ooluwgb/HashiCorp-Terraform-Professional-Prep)

A comprehensive study guide with notes, code examples, and exercises for the HashiCorp Certified: Terraform Authoring & Operations Professional exam.

---

## 📜 Table of Contents

- [About This Project](#-about-this-project)
- [🚀 How to Use This Repository](#-how-to-use-this-repository)
- [📋 Prerequisites](#-prerequisites)
- [🏗️ Structure](#️-structure)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

---

## 📖 About This Project

This repository is a complete study guide designed to help you prepare for and pass the **HashiCorp Certified: Terraform Authoring & Operations Professional** exam. It includes in-depth notes, practical code examples, and hands-on exercises to solidify your understanding of Terraform.

---

## 🚀 How to Use This Repository

To get the most out of this guide, it is recommended to follow this workflow for each part:

1.  **Start with the notes:** Each section's `notes.md` file provides a detailed explanation of the concepts.
2.  **Review the code examples:** The `examples` directory in each section contains Terraform code that demonstrates the concepts from the notes.
3.  **Complete the exercises:** Each part has a corresponding `exercises` directory to provide hands-on practice to test your knowledge.

---

## 📋 Prerequisites

Before you begin, you will need to have the following installed and configured:

-   **Terraform:** This guide is based on Terraform version 1.13.3 or higher. You can download it from the [official Terraform website](https://www.terraform.io/downloads.html).
-   **AWS Account & AWS CLI:** The examples and exercises in this guide use the AWS provider. You will need an AWS account and the AWS CLI configured to run the code.

---

## 🏗️ Structure

This repository is organized into the following parts. Each part contains its own set of `examples` and `exercises`.

### [Part 1: Terraform Core Concepts](./Part_1_Terraform_Core_Concepts)

| Section                                                                                    | Topics Covered                                                               |
| :----------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------- |
| [**Section 1: Introduction to Terraform**](./Part_1_Terraform_Core_Concepts/SECTION_1_Introduction_to_Terraform)     | Installation, Configuration, Versioning, Providers, Initialization.        |
| [**Section 2: Interacting with Terraform**](./Part_1_Terraform_Core_Concepts/SECTION_2_Interacting_with_Terraform) | Provider Blocks, `plan`, `apply`, and `destroy` commands.                  |
| [**Section 3: Terraform Language Basics**](./Part_1_Terraform_Core_Concepts/SECTION_3_Terraform_Language_Basics)    | Resources, Variables, Locals, and Outputs.                                   |
| **[Examples](./Part_1_Terraform_Core_Concepts/examples)** | Code examples for all concepts in Part 1. |
| **[Exercises](./Part_1_Terraform_Core_Concepts/exercises)** | Hands-on exercises for Part 1. |

### [Part 2: Advanced Terraform](./Part_2_Advanced_Terraform)

| Section                                                                                    | Topics Covered                                                               |
| :----------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------- |
| [**Section 4: State and Language**](./Part_2_Advanced_Terraform/SECTION_4_State_and_Language)                     | Backends, Meta-Arguments, Data Blocks, `import`, `moved`, and `removed` blocks. |
| [**Section 5: Dynamic Configurations**](./Part_2_Advanced_Terraform/SECTION_5_Dynamic_Configurations)           | Data Types, Functions, Variable Validation, Meta-Argument Validation, Check Blocks. |
| **[Examples](./Part_2_Advanced_Terraform/examples)** | Code examples for all concepts in Part 2. |
| **[Exercises](./Part_2_Advanced_Terraform/exercises)** | Hands-on exercises for Part 2. |

### [Part 3: Modules and Workflows](./Part_3_Modules_and_Workflows)

| Section                                                                                        | Topics Covered                                                               |
| :--------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------- |
| [**Section 6: Terraform Modules**](./Part_3_Modules_and_Workflows/SECTION_6_Terraform_Modules)                    | Module Blocks, Module Variables & Outputs, Module `import`/`moved` blocks.   |
| [**Section 7: Static Analysis and Testing**](./Part_3_Modules_and_Workflows/SECTION_7_Static_Analysis_and_Testing) | Static Analysis Tools, Testing Frameworks, Templating, HCP.                 |
| [**Section 8: Advanced Commands & Remote State**](./Part_3_Modules_and_Workflows/SECTION_8_Advanced_Commands_and_Remote_State)                  | Advanced Commands, Random Integer, Escape Sequences, Sensitive Parameters, Remote State, TFE. |
| **[Examples](./Part_3_Modules_and_Workflows/examples)** | Code examples for all concepts in Part 3. |
| **[Exercises](./Part_3_Modules_and_Workflows/exercises)** | Hands-on exercises for Part 3. |

### [Part 4: Exam Preparation](./Part_4_Exam_Preparation)

| Section                                                                              | Topics Covered                                                               |
| :----------------------------------------------------------------------------------- | :--------------------------------------------------------------------------- |
| [**Section 9: AWS Resources**](./Part_4_Exam_Preparation/SECTION_9_AWS_Resources)        | In-depth review of key AWS resources for the exam.                           |
| [**Section 10: Practice Exams**](./Part_4_Exam_Preparation/SECTION_10_Practice_Exams)    | Practice exams to test your knowledge and readiness for the certification.   |
| **[Examples](./Part_4_Exam_Preparation/examples)** | Code examples for all concepts in Part 4. |
| **[Exercises](./Part_4_Exam_Preparation/exercises)** | Hands-on exercises for Part 4. |

---

## 🤝 Contributing

Contributions are welcome! If you find any errors, have suggestions for improvements, or would like to add more examples or exercises, please open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.