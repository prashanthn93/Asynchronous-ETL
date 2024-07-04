from distutils.command import config
import aiohttp
import asyncio
import time
import json
from config import Config

class AsyncAPI():

    async def get_single_api(self, session, url):
        
        async with session.get(url, auth=aiohttp.BasicAuth(Config.uName, Config.password)) as resp:
            data = await resp.json()
            return data


    async def getData(self, apiURL, issues):
        if not issues:
            return None

        async with aiohttp.ClientSession() as session:

            tasks = []
            for issue in issues:
                url = apiURL + "/" + issue
                tasks.append(asyncio.ensure_future(self.get_single_api(session, url)))

            consoladatedData = await asyncio.gather(*tasks)
        return consoladatedData



    async def getAllCoverage(self,urls):
        tasks=[]
        async with aiohttp.ClientSession(headers={"Accept": "application/json ,text/javascript, */* " , "Content-Type": "application/x-www-form-urlencoded"}, auth=aiohttp.BasicAuth(self.uName, self.password)) as session:
            for key,url in urls.items():
                tasks.append(self.getCoverage(session,key,url))
            all_tasks=asyncio.gather(*tasks)   
            return await all_tasks

    async def getCoverage(self , session,key,url):
        params = {
            "startAt": 0,
            "maxResults": 100 
            }
        async with session.post(url,params=params ) as response:
            r = await response.read()
            data = json.loads(r)
            return {key:data}
