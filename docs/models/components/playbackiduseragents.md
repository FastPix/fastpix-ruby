# PlaybackIdUserAgents

Restrictions based on the user agent (which is typically a string sent by browsers or bots identifying themselves).


## Fields

| Field                                                                              | Type                                                                               | Required                                                                           | Description                                                                        |
| ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `default_policy`                                                                   | [T.nilable(Models::Components::PolicyAction)](../../models/shared/policyaction.md) | :heavy_minus_sign:                                                                 | Policy action type                                                                 |
| `allow`                                                                            | T::Array<*::String*>                                                               | :heavy_minus_sign:                                                                 | A list of specific user agents that are allowed to access the resource.            |
| `deny`                                                                             | T::Array<*::String*>                                                               | :heavy_minus_sign:                                                                 | A list of specific user agents that are blocked.                                   |