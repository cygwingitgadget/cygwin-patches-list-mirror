Return-Path: <cygwin-patches-return-4782-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30365 invoked by alias); 21 May 2004 20:37:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30354 invoked from network); 21 May 2004 20:37:04 -0000
Date: Fri, 21 May 2004 20:37:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [UG Patch] kmem and check_case typo
Message-ID: <20040521203704.GA7790@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040520141221.GA17516@cygbert.vinschen.de> <Pine.CYG.4.58.0405211012470.3524@fordpc.vss.fsi.com> <cb51e2e0405211317715f04d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb51e2e0405211317715f04d3@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00134.txt.bz2

On Fri, May 21, 2004 at 01:17:25PM -0700, Joshua Daniel Franklin wrote:
>On Fri, 21 May 2004 10:22:20 -0500, Brian Ford <ford@vss.fsi.com> wrote:
>> 
>> On Thu, 20 May 2004, Corinna Vinschen wrote:
>> 
>> > On May 20 09:22, Igor Pechtchanski wrote:
>> > > BTW, should /dev/kmem work also?
>> >
>> > No, only /dev/mem and /dev/port are working.  /dev/kmem is still looking
>> > for a contributor.
>> 
>> Ok, then shouldn't we apply the following patch to the users guide? (plus
>> a typo fix)
>> 
>> 2004-05-21  Brian Ford  <ford@vss.fsi.com>
>> 
>>         * pathnames.sgml: Remove /dev/kmem from the supported POSIX device
>>         list.
>> 
>>         * cygwinenv.sgml: Fix typo in check_case description.
>
>Looks good to me, I'll apply this weekend unless someone beats me to it. 

/dev/kmem should be mentioned as a work in progress looking for volunteers
rather than just removed outright.

IMO.

cgf
