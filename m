Return-Path: <cygwin-patches-return-4809-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12682 invoked by alias); 3 Jun 2004 19:54:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12671 invoked from network); 3 Jun 2004 19:54:40 -0000
Message-ID: <40BF81C4.1020105@att.net>
Date: Thu, 03 Jun 2004 19:54:00 -0000
From: David Fritz <zeroxdf@att.net>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net>
In-Reply-To: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00161.txt.bz2

I don't how much you want to rely on undocumented features, but ntdll.dll 
exports a function called RtlIsDosDeviceName_U().  The WINE implementation has 
the following to say about it:


/***********************************************************************
  *             RtlIsDosDeviceName_U   (NTDLL.@)
  *
  * Check if the given DOS path contains a DOS device name.
  *
  * Returns the length of the device name in the low word and its
  * position in the high word (both in bytes, not WCHARs), or 0 if no
  * device name is found.
  */
ULONG WINAPI RtlIsDosDeviceName_U( PCWSTR dos_name )




Also, from the patch:

	  /* COM and LPT must be followed by a single digit */

The code in src/winsup/cygwin/devices.cc would seem to indicate that the number 
is not limited to a single digit.


Cheers

