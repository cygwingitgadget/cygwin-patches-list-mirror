Return-Path: <cygwin-patches-return-3511-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10902 invoked by alias); 5 Feb 2003 17:56:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10890 invoked from network); 5 Feb 2003 17:56:31 -0000
Message-ID: <033d01c2cd3f$e732e020$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: "Igor Pechtchanski" <pechtcha@cs.nyu.edu>,
	"Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Cc: <cygwin-patches@cygwin.com>
References: <Pine.GSO.4.44.0302051226520.25432-100000@slinky.cs.nyu.edu>
Subject: Re: ntsec odds and ends (cygcheck augmentation?)
Date: Wed, 05 Feb 2003 17:56:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00160.txt.bz2

> On Wed, 5 Feb 2003, Pierre A. Humblet wrote:
>> The question of "Why is my HOME C:\ " could also be handled in
>> /etc/profile. I was thinking of putting something like this in it:
>> echo "Hello this is /etc/profile"
>> echo "You are a new user and I will verify your configuration".
>> echo "Delete these lines once everything is well".
>> if [ $uid -eq 400 ]; then etc...
>> echo "Your HOME is set to $HOME, the rules are 1).. 2).. 3).. 4).. "

Igor Pechtchanski wrote:
> How about just "Warning: HOME set to 'C:\', check your /etc/passwd or
> the value of HOME in the Windows environment"?  An advanced user (or
> one who simply wants to set his home to 'C:\') should be able to just
> comment out this warning from /etc/profile, right?

If this does happen, I prefer the more inobtrusive one.

At the moment, I can do all the customization I need in my home directory -
I'd rather not have to modify /etc/profile. Igor's suggestion is good,
because I cannot imaging anyone wanting C:\ as their home dir.


Max.
