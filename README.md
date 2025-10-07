# Emma Insurance Documentation

French-language insurance product documentation from major Canadian insurers, structured in markdown format with machine-readable metadata.

## Overview

This repository contains comprehensive insurance product documentation covering life insurance, disability insurance, critical illness coverage, and related products from leading Canadian insurance companies. All documents are in French (fr-CA) and structured for easy parsing and retrieval.

## Repository Structure

```
Produits - Assurance - Docs - French/
├── Assomption/          # Assomption Vie
├── Emma/                # Emma Services Financiers
├── Empire/              # L'Empire, Compagnie d'Assurance-Vie
├── Humania/             # Humania Assurance
├── iA/                  # iA Groupe financier
├── PPC/                 # Plan de Protection du Canada (PPC)
├── RBC/                 # RBC Assurances
└── UV/                  # UV Assurance (L'Union-Vie)
```

## Insurance Companies

| Company | Products | Document Count |
|---------|----------|----------------|
| **Assomption Vie** | Simplified life insurance (4 tiers) | 4 docs |
| **Emma** | Life, child rider, disability, critical illness | 3 docs |
| **Empire Vie** | Life, critical illness, preferred ratings | 5 docs |
| **iA Financial** | Life, disability, underwriting guides | 5 docs |
| **PPC** | Simplified issue life insurance | 1 doc |
| **RBC** | Disability insurance (multiple series) | 5 docs |
| **UV Assurance** | Life, term, permanent, riders | 14 docs |

## Document Types

- **Underwriting Guides** (`underwriting_guide`) - Risk assessment criteria
- **Product Guides** (`product_guide`) - Product features and benefits
- **Rate Guides** (`rate_guide`) - Premium calculations and tables
- **Application Forms** (`application_form`) - Data collection forms
- **Quick Reference** (`quick_reference_guide`) - Eligibility matrices
- **Policy Specimens** (`specimen_contract`) - Sample contracts
- **Technical Guides** (`technical_product_guide`) - Product specifications

## Document Format

All documents follow a consistent structure:

### YAML Frontmatter
```yaml
document_id: unique-identifier
document_type: type_classification
insurer: company_information
product: product_details
coverage: limits_and_ranges
tags: searchable_keywords
features: machine_readable_flags
```

### Content Sections
- Structured markdown with headers
- Tables for data presentation
- Embedded JSON for machine-readable data
- Cross-references and internal links
- Glossaries and definitions

## Usage

### Via MCP Server (Recommended)
Access this documentation through our MCP server:
- **Endpoint:** `https://emma-insurance-docs-production.up.railway.app/mcp`
- **Available Tools:**
  - `search_docs` - Semantic search across all documentation
  - `list_libraries` - List all available insurance providers
  - `fetch_documentation` - Retrieve specific documents

### Example Queries
- "What are UV's eligibility requirements for simplified issue life insurance?"
- "Compare RBC disability insurance series"
- "Find Empire Vie preferred underwriting criteria"
- "What medical requirements does iA Financial require?"

### Search by Company
Navigate to the company folder (e.g., `Assomption/`, `Emma/`, `RBC/`, `UV/`)

### Search by Product Type
Use tags in frontmatter:
- `assurance-vie` - Life insurance
- `assurance-invalidite` - Disability insurance
- `maladies-graves` - Critical illness
- `emission-simplifiee` - Simplified issue

### Search by Document Type
Filter by `document_type` in frontmatter

## Key Features

- ✅ Structured metadata for AI/LLM retrieval
- ✅ Consistent document schema (v2.0)
- ✅ Bilingual field names (FR/EN)
- ✅ Machine-readable tables and data
- ✅ Comprehensive tagging system
- ✅ Cross-referenced glossaries

## Metadata Standards

**Schema Version:** 2.0

**Required Fields:**
- `document_id` - Unique identifier
- `document_type` - Classification
- `insurer` - Company information
- `product` - Product details
- `language` - fr-CA
- `tags` - Searchability keywords

## Coverage Information

- **Age ranges:** 0-85 years (varies by product)
- **Coverage amounts:** $1,000 - $5,000,000 CAD (varies by product)
- **Product types:** Life, Disability, Critical Illness, Riders (varies by product)
- **Underwriting types:** Full, Simplified, Guaranteed Issue (varies by product)

## License

Proprietary insurance documentation. All rights reserved by respective insurance companies.

## Last Updated

October 2025

---

**Note:** This documentation is for reference purposes. For current product offerings and terms, consult directly with the respective insurance companies.