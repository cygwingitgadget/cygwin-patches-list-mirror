Return-Path: <cygwin-patches-return-3513-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31800 invoked by alias); 5 Feb 2003 18:29:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31791 invoked from network); 5 Feb 2003 18:29:21 -0000
Date: Wed, 05 Feb 2003 18:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Cc: cygwin-patches@cygwin.com
Subject: Re: ntsec odds and ends (cygcheck augmentation?)
Message-ID: <20030205183009.GI15400@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>,
	cygwin-patches@cygwin.com
References: <20030205164834.GE15400@redhat.com> <3.0.5.32.20030205114159.00800620@mail.attbi.com> <20030205164834.GE15400@redhat.com> <3.0.5.32.20030205123403.007e8a80@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030205123403.007e8a80@h00207811519c.ne.client2.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00162.txt.bz2

On Wed, Feb 05, 2003 at 12:34:03PM -0500, Pierre A. Humblet wrote:
>At 05:52 PM 2/5/2003 +0100, Corinna Vinschen wrote:
>>
>>Actually I would prefer that over this extra check, changing the
>>group name to "use mkpasswd".
>
>I had some hesitations too. For a while I considered changing the
>user name itself, but that would cause side effects.
>Changing the group name doesn't matter at all. It used to be set
>to "unknown", which provides no useful information.
>
>I would like to provide unmistakable feedback, before the user
>has a chance to write to the list and be told to run cygcheck.

I think that initial feedback is a *great* idea but if cygcheck can
provide some kind of information that would allow diagnosing a
problem, that would be useful, too.

Maybe it could just dump selected fields from /etc/passwd and
/etc/group.

cgf
