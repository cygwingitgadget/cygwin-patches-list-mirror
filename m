Return-Path: <cygwin-patches-return-4321-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16163 invoked by alias); 29 Oct 2003 01:48:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16152 invoked from network); 29 Oct 2003 01:48:18 -0000
Message-ID: <3F9F1C5B.2050501@netscape.net>
Date: Wed, 29 Oct 2003 01:48:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@sources.redhat.com
Subject: Add PAGE_SIZE, PAGE_SHIFT, PAGE_MASK to sys/param.h
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010102060201010200000409"
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q4/txt/msg00040.txt.bz2


--------------010102060201010200000409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1045

Hi,

I'm not sure how this would be taken... The only problem I see in doing 
this is if we ever decided to start supporting ia64/x86_64.  However, at 
that point we'd have to change a *ton* of other machine-dependant macros 
as well, so it seems like a rather trivial addition.  These macros seem 
to be fairly standard in both the linux and bsd worlds, so it would be 
very beneficial if we went ahead and defined them.  The reason I would 
like them is merely as a convienience factor in some socket work I'm 
doing.  I'm assuming that the windows default page shift, 12[*], will be 
an acceptable value that we can agree on?  This macro defines the base 
value upon which the aother macros calculate their values.  Based on 
that, I have attached a patch with those macros defined and some 
whitespace/tab cleanup cause by my last patch.  Because I'm not sure 
about my MUA, I've gzipped the patch to preserve formatting.

Cheers,
Nicholas

* This is the same value used by Linux/ia32, *BSD/ia32, Wine, and the 
Windows DDK in the cvs repo.

--------------010102060201010200000409
Content-Type: text/plain;
 name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog.txt"
Content-length: 242

2003-10-28  Nicholas Wourms  <nwourms@netscape.net>

    * include/sys/param.h: Define some page counting macros.
    (PAGE_SHIFT): Define.
    (PAGE_SIZE): Define.
    (PAGE_MASK): Define.
    Tidy tab/whitespace formatting from last patch.

--------------010102060201010200000409
Content-Type: application/x-gzip;
 name="cygwin-page-macros.patch.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cygwin-page-macros.patch.txt.gz"
Content-length: 1330

H4sICAoZnz8CA2N5Z3dpbi1wYWdlLW1hY3Jvcy5wYXRjaC50eHQApVVrb+JG
FP08/hVXWjW1AWPAfaQI2iSbfURLHiq7Sh+qqsEew0h4bM2MAfexv713bAw2
kGSlWkrGvr7n3HPuXA83ImSbIQT5fM2Fx0WwzELmqVx5KZU07i6s8f+/rJ9f
TyHiSzYEL1gpT8mg+MOSKku9p4t3VpZkWnK24mIOEhfFEwH9rm+FPIrAzcD1
wU3BlRiDSrLrus84Iv0BXGZzGPR6PvR7w4E//KYHbg8vYpjb7fZz6MEPcB/o
Et3rD31/iJECbV1cgPut3xl8D21c/HO4uLDgVcgiLhjcfZpMoHb1JviOCfRh
gdX2WvBxwRSDmAYyUUAlg9aKybwFIUsxjQoNaF0vGARpBklU3C4SpQHVaRZ3
Ad4na4aYjtVGfoXiGaxZQRVkUjKhlzly4D/seppIbZrKqT9wZ1SxEBBq2qsM
+SMXYbJWHSQo2MJEfK1BMEzTCawTKXOgsyTTKINqoGblCjSPGQoprazoMmOl
FaNV0ZhBQZYIDGem5CyHCRfZxuP++Xcd+PutZKxzj37/vZpeb4OPpntnBcXt
FB6WVEeJjOH6+kPJphLzDp1l84U26mboOUDHVBstLc9qV3vwcPnuzZ/T9zdv
P+IQEEKw65P7dwO7jN/89sY5kY5hYvc/TWA0qhE4BjzLNTOTMWfHuNvL6Qey
ZwYX+g6pQNjiSDENXKDeHb4YgyuuIUgyUewORuEVj/AjjeDu6upXy61q4GUC
cL4va57JeVFDZPGMSbORM64VlgFa1i0Iy6mr4R4eieJ/sSSyUZBzQGA8QooP
uOshmAw2Z7LoFFiwVRzTFL9P3Bvc1HKEuyahLhf9ohibdrgDtk2d323ueEbz
H/DPGPqjkY2Br0zAcRrAYCmfAp6N4bPdhDaxXGHZEnqEhReQWHeHfAkK4zH0
nH1Pa2bJi2Z3qJpT8iVOd8C9TfKyyxqqski+2GG55bflKYUf4n5WqQhB4kOI
D93G5C6SdUxF3mjvNmZvOpBjh02LN07btnPH7TuOh2tNaCOZnEqthrpeohCD
p5jYFilwRXqrwBzlZmldzlGRAgXGPn60KAfywxHfsgwqmibJmf25unUMC4+Q
AQ/NFI9tWZy6ep00KIs3SYR8RtNWFOLPcHHG4/rAHZglh2abiZVT8qRPcmDz
ED84uRl1i+Q5i+0TFskJf0fjFuPPckw3R6fL7c0dTvKs6hN1RvbMcX7Cm6G5
aeZe/tLM/bGZuxNXkZJTjPusLR05xQW70fwPSZM7SGsJAAA=

--------------010102060201010200000409--
