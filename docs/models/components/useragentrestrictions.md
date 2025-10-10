# UserAgentRestrictions

Restrictions based on the user agent


## Fields

| Field                                                                              | Type                                                                               | Required                                                                           | Description                                                                        |
| ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `default_policy`                                                                   | [T.nilable(Models::Components::PolicyAction)](../../models/shared/policyaction.md) | :heavy_minus_sign:                                                                 | Policy action type                                                                 |
| `allow`                                                                            | T::Array<*::String*>                                                               | :heavy_minus_sign:                                                                 | A list of user agents that are explicitly allowed access                           |
| `deny`                                                                             | T::Array<*::String*>                                                               | :heavy_minus_sign:                                                                 | A list of user agents that are explicitly denied access                            |