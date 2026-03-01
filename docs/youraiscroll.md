# YourAIScroll Setup Guide

YourAIScroll is a browser extension that exports AI chat conversations to Markdown. archchat relies on YourAIScroll to copy conversations to your clipboard with an `Original URL: <url>` header line — this is how archchat identifies the source platform and conversation.

## Installation

Install YourAIScroll for your browser:

- **Chrome**: [Chrome Web Store](https://chromewebstore.google.com/detail/youraiscroll-ai-chat-hist/nhipdhjmedoeicanabmcmihlncjcanfe)
- **Firefox**: [Firefox Add-ons](https://addons.mozilla.org/en-US/firefox/addon/youraiscroll-ai-chat-exporter)
- **Edge**: Install from the [Chrome Web Store](https://chromewebstore.google.com/detail/youraiscroll-ai-chat-hist/nhipdhjmedoeicanabmcmihlncjcanfe) (Edge supports Chrome extensions)

No account is required. The core export and clipboard copy feature is free with no signup.

## How to Use

1. Open a conversation on any supported AI platform (e.g., Claude, Grok, ChatGPT).
2. Click the **YourAIScroll** extension icon in your browser toolbar.
3. Click **"Copy to Markdown"** to copy the full conversation to your clipboard.
4. The clipboard content will start with `Original URL: <url>` followed by the conversation in Markdown format.
5. Switch to your terminal and run `archchat <project/topic>` to archive the conversation.

## Supported Platforms

YourAIScroll supports exporting from:

- Claude (claude.ai)
- Grok (grok.com)
- ChatGPT (chatgpt.com)
- Gemini (gemini.google.com)
- DeepSeek (deepseek.com)
- Perplexity (perplexity.ai)
- And more

## Important Notes

- archchat uses the **clipboard copy path only** ("Copy to Markdown"), not the file download path. The clipboard method provides the `Original URL:` header line that archchat requires.
- If the first line of the clipboard does not start with `Original URL:`, archchat will reject the input with an error.
