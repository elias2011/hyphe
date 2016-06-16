#!/usr/bin/env python

def setConfig(setting, value, filename, section=None):
    import json
    with open(filename, "r+") as filecontent:    
        data = json.load(filecontent)
        json.dumps(data)
        if section is not None:
            data[section][setting] = value
        else:
            data[setting] = value
        filecontent.seek(0)
        filecontent.truncate()
        json.dump(data, filecontent, indent=2)

def strToBool(string):
    if string in ["true", "True", "yes", "y"]:
        return True
    else:
        return False

from os import environ
if "HYPHE_MONGODB_HOST"     in environ: setConfig("host", environ["HYPHE_MONGODB_HOST"],"/app/config/config.json","mongo-scrapy")
if "HYPHE_MONGODB_PORT"     in environ: setConfig("mongo_port", int(environ["HYPHE_MONGODB_PORT"]),"/app/config/config.json","mongo-scrapy")
if "HYPHE_MONGODB_DBNAME"   in environ: setConfig("db_name", environ["HYPHE_MONGODB_DBNAME"],"/app/config/config.json","mongo-scrapy")
if "HYPHE_CRAWLER_PORT"     in environ: setConfig("scrapy_port", int(environ["HYPHE_CRAWLER_PORT"]),"/app/config/config.json","mongo-scrapy")
if "HYPHE_PROXY_HOST"       in environ: setConfig("proxy_host", environ["HYPHE_PROXY_HOST"],"/app/config/config.json","mongo-scrapy")
if "HYPHE_PROXY_PORT"       in environ: setConfig("proxy_port", int(environ["HYPHE_PROXY_PORT"]),"/app/config/config.json","mongo-scrapy")
if "HYPHE_MAXDEPTH"         in environ: setConfig("maxdepth", int(environ["HYPHE_MAXDEPTH"]),"/app/config/config.json","mongo-scrapy")
if "HYPHE_DOWNLOAD_DELAY"   in environ: setConfig("download_delay", int(environ["HYPHE_DOWNLOAD_DELAY"]),"/app/config/config.json","mongo-scrapy")
if "HYPHE_MAX_SIM_REQ"      in environ: setConfig("max_simul_requests", int(environ["HYPHE_MAX_SIM_REQ"]),"/app/config/config.json","mongo-scrapy")
if "HYPHE_HOST_MAX_SIM_REQ" in environ: setConfig("max_simul_requests_per_host", int(environ["HYPHE_HOST_MAX_SIM_REQ"]),"/app/config/config.json","mongo-scrapy")

if "HYPHE_MS_KEEPALIVE"       in environ: setConfig("keepalive", int(environ["HYPHE_MS_KEEPALIVE"]),"/app/config/config.json","memoryStructure")
if "HYPHE_MS_THRIFT_MAXRAM"   in environ: setConfig("thrift.max_ram", int(environ["HYPHE_MS_THRIFT_MAXRAM"]),"/app/config/config.json","memoryStructure")
if "HYPHE_MS_LUCENE_ROOTPATH" in environ: setConfig("lucene.rootpath", environ["HYPHE_MS_LUCENE_ROOTPATH"],"/app/config/config.json","memoryStructure")
if "HYPHE_MS_LOG_LEVEL"       in environ: setConfig("log.level", environ["HYPHE_MS_LOG_LEVEL"],"/app/config/config.json","memoryStructure")
if "HYPHE_MS_SIM_PAGES_INDEX" in environ: setConfig("max_simul_pages_indexing", int(environ["HYPHE_MS_SIM_PAGES_INDEX"]),"/app/config/config.json","memoryStructure")
if "HYPHE_MS_SIM_LINKS_INDEX" in environ: setConfig("max_simul_links_indexing", int(environ["HYPHE_MS_SIM_LINKS_INDEX"]),"/app/config/config.json","memoryStructure")

if "HYPHE_OPEN_CORS_API"   in environ: setConfig("OPEN_CORS_API", strToBool(environ["HYPHE_OPEN_CORS_API"]) ,"/app/config/config.json")
if "HYPHE_BACKEND_PORT"    in environ: setConfig("twisted.port", int(environ["HYPHE_BACKEND_PORT"]) ,"/app/config/config.json")
if "HYPHE_PRECISION_LIMIT" in environ: setConfig("precisionLimit", int(environ["HYPHE_PRECISION_LIMIT"]) ,"/app/config/config.json")
if "HYPHE_MULTICORPUS"     in environ: setConfig("MULTICORPUS", strToBool(environ["HYPHE_MULTICORPUS"]) ,"/app/config/config.json")
if "HYPHE_ADMIN_PASSWORD"  in environ: setConfig("ADMIN_PASSWORD", environ["HYPHE_ADMIN_PASSWORD"] ,"/app/config/config.json")
if "HYPHE_DEBUG"           in environ: setConfig("DEBUG", environ["HYPHE_DEBUG"] ,"/app/config/config.json")

from subprocess import call
call(["twistd", "--python=/app/hyphe_backend/core.tac", "--nodaemon", "--no_save", "--pidfile="])
