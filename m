Return-Path: <cygwin-patches-return-3982-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10776 invoked by alias); 30 Jun 2003 21:39:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10767 invoked from network); 30 Jun 2003 21:39:51 -0000
X-Originating-IP: [68.80.118.176]
X-Originating-Email: [rkitover@hotmail.com]
From: "Rafael Kitover" <caelum@debian.org>
To: <cygwin-patches@cygwin.com>
Subject: Re: EIO error on background tty reads
Date: Mon, 30 Jun 2003 21:39:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <Law9-OE66lmpcQABZTW0000d939@hotmail.com>
X-OriginalArrivalTime: 30 Jun 2003 21:39:50.0720 (UTC) FILETIME=[229DB400:01C33F50]
X-SW-Source: 2003-q2/txt/msg00209.txt.bz2

cgf wrote:
>>What I don't understand is if a background write to a terminal without
>>sending a
>>SIGTTOU which it explicitly ignores is allowed, why not a background read?
>
>Because that's the way it works.  Have you tried this with linux?  I wrote
>a test case yesterday.  linux raises an EIO when a background read is
>attempted, SIGTTIN is ignored, and the process is not a member of the
>terminal's process group.  Test case below.

Thank you for the test case! The problem with screen may have had more
to do with the process group than with the read itself, I will do more
testing on cygwin and linux and fix the appropriate sources, in which case
I'm sorry for having wasted your time.

-- 
Rafael
