Return-Path: <cygwin-patches-return-3352-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2614 invoked by alias); 6 Jan 2003 21:03:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2602 invoked from network); 6 Jan 2003 21:03:01 -0000
Message-ID: <3E19EE90.7030502@ece.gatech.edu>
Date: Mon, 06 Jan 2003 21:03:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] export asprintf and friends
References: <3E13C60B.4000904@ece.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00001.txt.bz2

The newlib patch has been applied, so this change to winsup -- if 
desired -- can be committed.

Charles Wilson wrote:
> This patch assumes that the asprintf.c change I submitted to newlib is 
> also applied.  (And no, it doesn't fix the problem I was having with 
> glib and the printf functions, but I noticed this oversight -- and the 
> newlib typo -- while doing that investigation)
> 
> 2003-01-01  Charles Wilson  <cwilson@ece.gatech.edu>
> 
>     * cygwin.din: add asprintf and vasprintf, as
>     well as the reentrant versions and underscore
>     variants.
