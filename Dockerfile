# পূর্ণাঙ্গ Node.js 20 ইমেজ ব্যবহার (slim-এর বদলে)
FROM node:20

# সিস্টেম ডিপেন্ডেন্সি
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*

# npm ক্যাশ পরিষ্কার
RUN npm cache clean --force

# OpenAI Codex CLI গ্লোবালি ইনস্টল
RUN npm install -g @openai/codex

# Codex Web গ্লোবালি ইনস্টল (--ignore-scripts সহ)
RUN npm install -g --ignore-scripts github:0xcaff/codex-web

# নন-রুট ইউজার
RUN useradd -m -s /bin/bash codex
USER codex
WORKDIR /home/codex

# এন্ট্রিপয়েন্ট
COPY entrypoint.sh /entrypoint.sh
USER root
RUN chmod +x /entrypoint.sh
USER codex

EXPOSE 8214
ENTRYPOINT ["/entrypoint.sh"]
