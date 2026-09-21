# Node.js 20 বেস ইমেজ ব্যবহার (Codex Web-এর জন্য প্রয়োজন)
FROM node:20-slim

# সিস্টেম ডিপেন্ডেন্সি ইনস্টল
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# OpenAI Codex CLI গ্লোবালি ইনস্টল
RUN npm install -g @openai/codex

# Codex Web গ্লোবালি ইনস্টল (GitHub থেকে)
RUN npm install -g github:0xcaff/codex-web

# নন-রুট ইউজার তৈরি
RUN useradd -m -s /bin/bash codex
USER codex
WORKDIR /home/codex

# এন্ট্রিপয়েন্ট স্ক্রিপ্ট কপি ও এক্সিকিউটেবল করা
COPY entrypoint.sh /entrypoint.sh
USER root
RUN chmod +x /entrypoint.sh
USER codex

# ডকুমেন্টেশন অনুযায়ী ডিফল্ট পোর্ট
EXPOSE 8214

# এন্ট্রিপয়েন্ট সেট
ENTRYPOINT ["/entrypoint.sh"]
