# 使用最轻量的 Python 镜像
FROM python:3.10-slim

WORKDIR /app

# 安装系统必要零件
RUN apt-get update && apt-get install -y gcc g++ curl && rm -rf /var/lib/apt/lists/*

# 先安装依赖，利用缓存
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 拷贝全量代码
COPY . .

# 暴露端口（Zeabur 默认喜欢 8080）
EXPOSE 8080

# 既然它不支持 sse，我们就用它唯一认识的网络模式 http
CMD ["python", "-m", "mcp_server.server", "--transport", "http", "--host", "0.0.0.0", "--port", "8080"]
