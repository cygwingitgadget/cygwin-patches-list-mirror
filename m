Return-Path: <cygwin-patches-return-3353-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20313 invoked by alias); 7 Jan 2003 00:53:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20304 invoked from network); 7 Jan 2003 00:53:44 -0000
Message-ID: <3E1A24A3.9040807@ece.gatech.edu>
Date: Tue, 07 Jan 2003 00:53:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] export asprintf and friends
References: <3E13C60B.4000904@ece.gatech.edu> <3E19EE90.7030502@ece.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00002.txt.bz2

My bad.  vasprintf.c hasn't been added to any of the newlib makefiles, 
so the _vasprintf_r and vasprintf symbols are not available for export. 
  So this patch isn't quite ready for application yet.

---Chuck

Charles Wilson wrote:
> The newlib patch has been applied, so this change to winsup -- if 
> desired -- can be committed.
> 
> Charles Wilson wrote:
> 
>> This patch assumes that the asprintf.c change I submitted to newlib is 
>> also applied.  (And no, it doesn't fix the problem I was having with 
>> glib and the printf functions, but I noticed this oversight -- and the 
>> newlib typo -- while doing that investigation)
>>
>> 2003-01-01  Charles Wilson  <cwilson@ece.gatech.edu>
>>
>>     * cygwin.din: add asprintf and vasprintf, as
>>     well as the reentrant versions and underscore
>>     variants.
> 
> 
> 

