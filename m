Return-Path: <cygwin-patches-return-3548-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25065 invoked by alias); 8 Feb 2003 11:10:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25055 invoked from network); 8 Feb 2003 11:10:18 -0000
Message-Id: <3.0.5.32.20030208060945.00803760@localhost>
X-Sender: pierre@localhost (Unverified)
Date: Sat, 08 Feb 2003 11:10:00 -0000
To: <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: ntsec odds and ends
In-Reply-To: <009b01c2cdf1$410e64f0$78d96f83@pomello>
References: <Pine.GSO.4.44.0302060941150.15853-100000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00197.txt.bz2

At 03:05 PM 2/6/2003 -0000, Max Bowsher wrote:
>>>> +      if (myself->uid == UNKNOWN_UID)
>>>> + strcpy (group_name, "run mkpasswd"); /* Feedback... */
>>>
>>> I've changed that to just "mkpasswd".
>>>
>>> I don't like to introduce group names with spaces in it.  And since
>>> they are longer than 8 chars, they'd get truncated by ls anyway.
>
>Having a space in the names makes it much more obvious that something odd is
>happening. And these names should never be allowed to persist for long.
>
>Truncation by ls shouldn't matter much. I would say that a new user is more
>likely to notice "run mkpa" than "mkpasswd".

Max got exactly right why I had put the "run" in. 
1.3.19 already contains an embryo of the ideas. The group is set to 
"mkgroup" if things look wrong (either passwd or group).
Unfortunately look at <http://cygwin.com/ml/cygwin/2003-02/msg00302.html>

A new user took the trouble to send us the outputs of "id" AND "ls -l".
The word "mkgroup" is in plain view but didn't excite any neurons 
(it does to us, because we already know of mkgroup).  
That's why I thought that an imperative could help, as short as possible
"do", "go", "run",... , something that won't look as a plausible group name. 
"dumbass" has merit, but at that stage it's not the user's fault if passwd 
is incomplete. Flashing ls has merit too, but I'd rather restrict the 
changes to cygwin itself (dll or install scripts).

Earlier I wrote that I considered changing the user's name, but that it
could have side effects. I was afraid of /etc/profile creating a directory
under the incorrect name. After reviewing it, I see that I was wrong. 
HOME is always set in a way that doesn't depend on the user name
and the home directory is always set from the current HOME.

So we could consider changing the user's name if it is not in /etc/passwd.
That would be much more detectable than changing the group name.
Using the formats of "ls -l" and "id" we could set the name to
"run mkpa" and the group to "sswd   and mkgroup to set your identity".
(the last 6 words will only show in "id"),
or the name to "type mkp", where mkp would be a shell script explaining what
to do, or to some other combination yet to be contributed.
 
Pierre 
[I am not back, this is a one shot over dialup from a borrowed account]
