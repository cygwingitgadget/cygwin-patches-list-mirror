Return-Path: <cygwin-patches-return-1684-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6419 invoked by alias); 12 Jan 2002 20:22:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6405 invoked from network); 12 Jan 2002 20:22:27 -0000
Date: Sat, 12 Jan 2002 12:22:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
Message-ID: <20020112202242.GF21924@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <911C684A29ACD311921800508B7293BA037D29E6@cnmail> <20020112031851.GA5052@redhat.com> <032e01c19b4a$35230fe0$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032e01c19b4a$35230fe0$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00041.txt.bz2

On Sat, Jan 12, 2002 at 08:19:15PM +1100, Robert Collins wrote:
>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>> These are nice changes, but I have a few observations:
>
>> 2) I don't think there is any reason to report the number if you
>>    are translating the text, so, I'd prefer:
>>
>>    mkpasswd: The user name could not be found
>
>My 2c: keep the number. Put it in brackets or something. It's a _lot_
>easier for sysadmins.

Sorry.  I don't agree.  We don't put the errno in all of our other
messages.  I don't see any reason to include the Windows error number.

cgf
