# DomainRestrictions

Restrictions based on the originating domain of a request


## Fields

| Field                                                                              | Type                                                                               | Required                                                                           | Description                                                                        |
| ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `default_policy`                                                                   | [T.nilable(Models::Components::PolicyAction)](../../models/shared/policyaction.md) | :heavy_minus_sign:                                                                 | Policy action type                                                                 |
| `allow`                                                                            | T::Array<*::String*>                                                               | :heavy_minus_sign:                                                                 | A list of domain names or patterns that are explicitly allowed access              |
| `deny`                                                                             | T::Array<*::String*>                                                               | :heavy_minus_sign:                                                                 | A list of domain names or patterns that are explicitly denied access               |