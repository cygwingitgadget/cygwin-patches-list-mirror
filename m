Return-Path: <cygwin-patches-return-1528-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 1292 invoked by alias); 27 Nov 2001 18:42:28 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 1278 invoked from network); 27 Nov 2001 18:42:28 -0000
Date: Thu, 18 Oct 2001 08:16:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Message-ID: <20011127184223.GA24028@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3C035977.BF151D0A@syntrex.com> <000601c17772$7c5ecfd0$2101a8c0@d8rc020b>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601c17772$7c5ecfd0$2101a8c0@d8rc020b>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00060.txt.bz2

On Tue, Nov 27, 2001 at 12:36:52PM -0600, Gary R Van Sickle wrote:
>> "Gary R. Van Sickle" wrote:
>> >
>> > Ok, setup.exe seems to work much better with this patch
>> applied (also attached):
>>
>> Yep, I'm the one that screwed this up. Here is how it was before
>> my patch was applied.
>>
>>   do {
>>     l = s->gets ();
>>     if (_strnicmp (l, "Content-Length:", 15) == 0)
>>       sscanf (l, "%*s %d", &file_size);
>>   } while (*l);
>>
>>
>> What about replacing this in your patch:
>> > +  while (((l = s->gets ()) != 0) && (strlen(l) != 0))
>> with
>>   +  while (((l = s->gets ()) != 0) && *l)
>>
>
>Ah, better yet.  Jeez you guys are clever ;-).  But how about we make it:
>
>	while (((l = s->gets ()) != 0) && (*l != '\0'))
>
>in the interest of making it a bit more self-documenting?

Actually, how about not using != 0.  Use NULL in this context.

I don't think that *l is hard to understand, fwiw.

cgf
