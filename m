Return-Path: <cygwin-patches-return-4567-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27301 invoked by alias); 11 Feb 2004 01:06:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27291 invoked from network); 11 Feb 2004 01:06:07 -0000
Message-ID: <40297FF2.50403@netscape.net>
Date: Wed, 11 Feb 2004 01:06:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
MIME-Version: 1.0
To: cygwin-patches@sources.redhat.com
Subject: *Ping*: fix strace and ssp opts for getopt argument permutation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2004-q1/txt/msg00057.txt.bz2

Hi,

Can someone please comment on what's holding up this patch:
http://sources.redhat.com/ml/cygwin-patches/2003-q4/msg00223.html

AFAICT, it was silently dropped without any reason.  I'm waiting on 
someone to commit it so that I can submit my update to getopt which 
brings in the OpenBSD additions, including new getopt_long_only support.

IANAL, but the modifications are soooo small (in fact half of them 
modify whitespace/comments) that I really should think it not be 
necessary to require an assignment.

Thanks in advance.

Cheers,
Nicholas
