Return-Path: <cygwin-patches-return-4373-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19549 invoked by alias); 14 Nov 2003 12:49:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19539 invoked from network); 14 Nov 2003 12:49:14 -0000
Message-ID: <04e701c3aaad$b42fee10$78d96f83@starfruit>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <3FB4A341.5070101@cygwin.com> <20031114101815.GU18706@cygbert.vinschen.de> <3FB4AE07.6010101@cygwin.com> <041701c3aaa4$db725ed0$78d96f83@starfruit> <3FB4C321.6030507@cygwin.com>
Subject: Re: thunk createDirectory and createFile calls
Date: Fri, 14 Nov 2003 12:49:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
X-SW-Source: 2003-q4/txt/msg00092.txt.bz2

Robert Collins wrote:
> Max Bowsher wrote:
>
>
>> Also, I think LPCTSTR should be LPCSTR ? (and also in the CreateFile
>> case)
>>
>
> Not according to MSDN.

Can you give a link to the bit you are looking at?

http://msdn.microsoft.com/library/default.asp?url=/library/en-us/intl/unicode_9i79.asp
seems to support my suggestion.

> (excuse the unsigned emails, I don't have gpg setup with thunderbird
> on cygwin :[)

Ah. I'd wondered why OE wasn't choking on your emails :-)


Max.
