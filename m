Return-Path: <cygwin-patches-return-4374-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25746 invoked by alias); 14 Nov 2003 12:56:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25737 invoked from network); 14 Nov 2003 12:56:40 -0000
Message-ID: <3FB4D118.8030802@cygwin.com>
Date: Fri, 14 Nov 2003 12:56:00 -0000
From: Robert Collins <rbcollins@cygwin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Bowsher <maxb@ukf.net>
CC:  cygwin-patches@cygwin.com
Subject: Re: thunk createDirectory and createFile calls
References: <3FB4A341.5070101@cygwin.com> <20031114101815.GU18706@cygbert.vinschen.de> <3FB4AE07.6010101@cygwin.com> <041701c3aaa4$db725ed0$78d96f83@starfruit> <3FB4C321.6030507@cygwin.com> <04e701c3aaad$b42fee10$78d96f83@starfruit>
In-Reply-To: <04e701c3aaad$b42fee10$78d96f83@starfruit>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00093.txt.bz2

Max Bowsher wrote:

> Robert Collins wrote:
> 
>>Max Bowsher wrote:
>>
>>
>>
>>>Also, I think LPCTSTR should be LPCSTR ? (and also in the CreateFile
>>>case)
>>>
>>
>>Not according to MSDN.
> 
> 
> Can you give a link to the bit you are looking at?
> 
> http://msdn.microsoft.com/library/default.asp?url=/library/en-us/intl/unicode_9i79.asp
> seems to support my suggestion.


http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/base/createfile.asp

Look at the grey box :}.

Rob
