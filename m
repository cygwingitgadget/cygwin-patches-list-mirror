Return-Path: <cygwin-patches-return-4376-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28235 invoked by alias); 14 Nov 2003 13:04:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28221 invoked from network); 14 Nov 2003 13:04:51 -0000
Message-ID: <050601c3aaaf$cbe72df0$78d96f83@starfruit>
From: "Max Bowsher" <maxb@ukf.net>
To: "Robert Collins" <rbcollins@cygwin.com>
Cc: <cygwin-patches@cygwin.com>
References: <3FB4A341.5070101@cygwin.com> <20031114101815.GU18706@cygbert.vinschen.de> <3FB4AE07.6010101@cygwin.com> <041701c3aaa4$db725ed0$78d96f83@starfruit> <3FB4C321.6030507@cygwin.com> <04e701c3aaad$b42fee10$78d96f83@starfruit> <3FB4D118.8030802@cygwin.com>
Subject: Re: thunk createDirectory and createFile calls
Date: Fri, 14 Nov 2003 13:04:00 -0000
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
X-SW-Source: 2003-q4/txt/msg00095.txt.bz2

Robert Collins wrote:
> Max Bowsher wrote:
>
>> Robert Collins wrote:
>>
>>> Max Bowsher wrote:
>>>
>>>
>>>
>>>> Also, I think LPCTSTR should be LPCSTR ? (and also in the
>>>> CreateFile case)
>>>>
>>>
>>> Not according to MSDN.
>>
>>
>> Can you give a link to the bit you are looking at?
>>
>>
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/intl/unicode_9i79.asp
>> seems to support my suggestion.
>
>
>
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/base/createfile.asp
>
> Look at the grey box :}.

Exactly. CreateFile takes LPCTSTR - but you are calling CreateFileA, which
takes LPCSTR.

Granted, LPCTSTR == LPCSTR when UNICODE is not defined - but if you are
relying on that, you don't need to bother with the "A" suffix on the
function, either.

Max.
