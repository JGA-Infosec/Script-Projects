# Script-Projects

These are my collection of the scripts I made
A collection of custom automation scripts written in Bash and Python for rapid perimeter enumeration and vulnerability research.

## 📑 Table of Contents
* [Reconnaissance Chain Script](#reconnaissance-chain)

---

<p align="left">
  <img src="https://img.shields.io/badge/Project-Reconnaissance__Chain-407849?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Language-Bash-252B27?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Type-Automation__Workflow-252B27?style=for-the-badge" />
</p>
> **File:** `recon_chain.sh` | **Language:** Bash
> **Core Utilities:** `ping`, `rustscan`, `udpx`, `nmap`, `subfinder`

> *Note: This is the very first interactive workflow script I ever wrote. It serves as the baseline for my development journey, demonstrating my initial approach to chaining discovery tools before transitioning to fully headless automation.*

> ### Objective
> To streamline the repetitive initial stages of a host assessment by chaining basic ICMP discovery, lightning-fast TCP port scanning (Rustscan), UDP probing, and targeted Nmap execution into a single interactive terminal workflow.

> ### How It Works
> 1. Prompts the user for a target IP address.
2. Performs an initial ICMP ping check to verify host availability before launching intensive network scans.
3. Executes `rustscan` for rapid TCP port discovery, allowing the user to select raw or grepable output.
4. Leverages `udpx` to identify exposed UDP services.
5. Utilizes conditional interactive prompts to optionally launch deeper `nmap` footprinting and `subfinder` perimeter enumeration based on the initial findings.

### Limitations of this Project
* **Interactive Halting:** The script requires active user input to progress through the later stages (Nmap, Subfinder), preventing unattended execution.
* **Output Routing:** Currently, tool outputs are printed directly to the terminal, and some background data is routed to `/dev/null`.
