# ♫ [The Dream of the 90's](https://youtu.be/U4hShMEk1Ew) ♫ is alive in ~~Portland~~ ["a weird suite of Enterprise LLM tools"](https://github.com/users/rabbidave/projects/1) named after [Nicktoons](https://en.wikipedia.org/wiki/Nicktoons)
### by [some dude in his 30s](https://www.linkedin.com/in/davidisaacpierce)
#
## Utility 2) SpongeBob's Imaginary API Endpoints

![SpongeBob](https://res.cloudinary.com/teepublic/image/private/s--IiGptBOg--/t_Preview/b_rgb:ffffff,c_limit,f_auto,h_630,q_90,w_630/v1597843910/production/designs/13214187_1.jpg "SpongeBob")

## Description:
 A Terraform module, and set of tfvars, that allow provisioning of a [reverse proxy](https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy/) via [Nginx](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/) via EC2 for the puprose of redirecting LLM traffic from SDKs and applications not already configured to support open-source models

#
## Rationale:

1) Use of SOTA models for prototyping makes sense, as do the myriad integrations for GPT4 that resulted. That said, OpenAI has adopted a [model deprecation policy](https://platform.openai.com/docs/deprecations) that will break integrations from legacy apps using awesome [SDKs like Semantic Kernel](https://github.com/microsoft/semantic-kernel)
2) User experience, instrumentation, grounding, and metadata capture are crucial to the adoption of LLMs for orchestration of [multi-modal agentic systems](https://en.wikipedia.org/wiki/Multi-agent_system); a useful reverse proxy drives adoption

#
## Intent:

The intent is to redirect traffic that originally required proprietary OpenAI endpoints via the EC2 instance (Nginx reverse proxy).

The endpoints being redirected are as follows

1) Embeddings: https://api.openai.com/v1/embeddings
2) Chat: https://api.openai.com/v1/chat/completions
3) Audio Transcriptions: https://api.openai.com/v1/audio/transcriptions
4) Audio Translations: https://api.openai.com/v1/audio/translations
5) Moderation: https://api.openai.com/v1/moderations

#
### Note: Needs externalization of the user_data section into a separate script; opening an issue with myself but he's not a great PM (more of an architect type)