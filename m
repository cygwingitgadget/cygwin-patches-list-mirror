Return-Path: <cygwin-patches-return-3525-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3774 invoked by alias); 6 Feb 2003 15:06:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3756 invoked from network); 6 Feb 2003 15:06:03 -0000
Message-ID: <009b01c2cdf1$410e64f0$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <Pine.GSO.4.44.0302060941150.15853-100000@slinky.cs.nyu.edu>
Subject: Re: ntsec odds and ends
Date: Thu, 06 Feb 2003 15:06:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00174.txt.bz2

> On Thu, 6 Feb 2003, Corinna Vinschen wrote:
>>> -      char group_name [UNLEN + 1] = "mkgroup";
>>> +      char group_name [UNLEN + 1] = "run mkgroup";
>>
>> I didn't commit this change.
>>
>>> +      if (myself->uid == UNKNOWN_UID)
>>> + strcpy (group_name, "run mkpasswd"); /* Feedback... */
>>
>> I've changed that to just "mkpasswd".
>>
>> I don't like to introduce group names with spaces in it.  And since
>> they are longer than 8 chars, they'd get truncated by ls anyway.

Having a space in the names makes it much more obvious that something odd is
happening. And these names should never be allowed to persist for long.

Perhaps you would consider some punctuation in the names instead?
e.g.: <mkpasswd> <mkgroup>

Truncation by ls shouldn't matter much. I would say that a new user is more
likely to notice "run mkpa" than "mkpasswd".



Max.
