Return-Path: <cygwin-patches-return-3400-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9784 invoked by alias); 15 Jan 2003 18:29:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9775 invoked from network); 15 Jan 2003 18:29:34 -0000
Date: Wed, 15 Jan 2003 18:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Where to put my basename() and dirname() implementation...
Message-ID: <20030115183034.GH15975@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <59A835EDCDDBEB46BC75402F4604D5528F75D6@elmer> <009201c2bcc0$82411040$305886d9@webdev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009201c2bcc0$82411040$305886d9@webdev>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00049.txt.bz2

On Wed, Jan 15, 2003 at 06:04:06PM -0000, Elfyn McBratney wrote:
>Doooh! Thanks for the heads up Sergey. It kinda seems pointless just adding
>a dirname() function but what the hell... Any inkling where i should put
>this lone sub?

I don't want to add any more libiberty routines to cygwin since the
licensing is suspect.  So, please follow the normal submission rules.
Probably miscfuncs.cc is the place to add this.

cgf

>----- Original Message -----
>From: "Sergey Okhapkin" <sos@sokhapkin.dyndns.org>
>To: "'Elfyn McBratney'" <elfyn-cygwin@exposure.org.uk>;
><cygwin-patches@cygwin.com>
>Sent: Wednesday, January 15, 2003 5:56 PM
>Subject: RE: Where to put my basename() and dirname() implementation...
>
>
>> Basename() is implemented in libiberty already, just modify cygwin.din
>> :-)
>>
>> > -----Original Message-----
>> > From: cygwin-patches-owner@cygwin.com
>> > [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Elfyn McBratney
>> > Sent: Wednesday, January 15, 2003 12:37 PM
>> > To: cygwin-patches@cygwin.com
>> > Subject: Where to put my basename() and dirname() implementation...
>> >
>> >
>> > I have finished my basename() and dirname() (so long for
>> > something so simple
>> > ;-) implementation and I have two questions:
>> >
>> > 1) Where would be the best place to put these functions? I
>> > was thinking dir.cc or path.cc?
>> > 2) What header file (winsup/cygwin/include) should I put the
>> > prototypes into? On my sun and redhat box they're in libgen.h
>> > so should I follow this convention?
>> >
>> > Once I have these answered I will submit the patch here.
>> >
>> > Elfyn
>> > elfyn@exposure.org.uk
>> >
>> >
>> >
>> >
>>
>>
>
>
