# PlaybackIdDomains

Restrictions based on the originating domain of a request (for example, whether requests from certain websites must be allowed or blocked).


## Fields

| Field                                                                              | Type                                                                               | Required                                                                           | Description                                                                        |
| ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `default_policy`                                                                   | [T.nilable(Models::Components::PolicyAction)](../../models/shared/policyaction.md) | :heavy_minus_sign:                                                                 | Policy action type                                                                 |
| `allow`                                                                            | T::Array<*::String*>                                                               | :heavy_minus_sign:                                                                 | A list of domains that are explicitly allowed access.                              |
| `deny`                                                                             | T::Array<*::String*>                                                               | :heavy_minus_sign:                                                                 | A list of domains that are explicitly blocked from accessing the resource.         |