Return-Path: <cygwin-patches-return-4832-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14503 invoked by alias); 8 Jun 2004 10:12:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14481 invoked from network); 8 Jun 2004 10:11:56 -0000
Message-ID: <40C59105.1000202@msgid.corpit.ru>
Date: Tue, 08 Jun 2004 10:12:00 -0000
From: Egor Duda <deo@corpit.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: make IPC_INFO visible to ipc system utilities only
References: <40C5871E.9010801@msgid.corpit.ru> <20040608100117.GA17957@cygbert.vinschen.de>
In-Reply-To: <20040608100117.GA17957@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00184.txt.bz2

Corinna Vinschen wrote:
>>Currently IPC_INFO is defined whenever we include sys/sem.h, but struct
>>seminfo, which is returned by semctl(IPC_INFO) is defined only for
>>_KERNEL applications. This inconsistency breaks, for instance,
>>libmudflap builds. I believe there's no point to have IPC_INFO in
>>non-_KERNEL application
> 
> 
>   as long as we can't get semctl(IPC_INFO) results right anyway.
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   What is the author trying to tell me here?!?

I was unclear here, probably. I meant that "userspace application", i.e. 
application which includes sys/sem.h but don't define _KERNEL, may call 
semctl(IPC_INFO), but result of this call will have no meaning for 
application since it can't interpret it.

So by "we" in underscored sentence i meant "userspace", non-system ipc 
application.

egor
