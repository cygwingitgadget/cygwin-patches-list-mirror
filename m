Return-Path: <cygwin-patches-return-2169-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10211 invoked by alias); 9 May 2002 22:21:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10197 invoked from network); 9 May 2002 22:21:35 -0000
X-Originating-IP: [148.87.1.170]
From: "david f" <davidf87@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc: 
Subject: Re: Fwd: write(2) return codes 
Date: Thu, 09 May 2002 15:21:00 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F135QhN4RWtsrHNC1On00011d9a@hotmail.com>
X-OriginalArrivalTime: 09 May 2002 22:21:35.0869 (UTC) FILETIME=[E18B5AD0:01C1F7A7]
X-SW-Source: 2002-q2/txt/msg00153.txt.bz2

>Your patch just blindly sets EBADF when the windows error is
>ERROR_ACCESS_DENIED.  I am not convinced that this is a correct
>solution.
>
>cgf

I'm not certain either. I have no experience programming for windows.

The docs for ReadFile/WriteFile did not even indicate that 
ERROR_ACCESS_DENIED was a valid return code. The idea of access failure 
makes more sense for open or create.

I have no idea what else could cause it. But I suspect there are no cases 
where write returns EACCES under POSIX.


David F

_________________________________________________________________
Join the worlds largest e-mail service with MSN Hotmail. 
http://www.hotmail.com
