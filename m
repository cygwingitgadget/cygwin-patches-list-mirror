Return-Path: <cygwin-patches-return-4038-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27044 invoked by alias); 5 Aug 2003 04:49:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27035 invoked from network); 5 Aug 2003 04:49:48 -0000
Date: Tue, 05 Aug 2003 04:49:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] patch.cc: cygdrive_getmntent () - Unify behaviour with fhandler_cygdrive
Message-ID: <20030805044947.GA5641@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030802141248.GB16831@redhat.com> <13970.1059840677@www56.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13970.1059840677@www56.gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00054.txt.bz2

On Sat, Aug 02, 2003 at 06:11:17PM +0200, Pavel Tsekov wrote:
>> On Sat, Aug 02, 2003 at 01:53:21PM +0200, Pavel Tsekov wrote:
>> >Here is a simple patch which makes the behaviour of getmntent ()
>> >consistent with the one of fhandler_cygdrive.
>> 
>> The reason this is there is to avoid long delays in mount table
>> listings.
>
>Well, I guessed so, but it would be more convinient and consistent if
>calling getmntent() could retrieve all the accesible (mounted) drives.
>Anyway, I guess i'll be using readdir () :)

After giving this a couple days of thought, I decided that this was
not hobgoblin related so I'm going to check this in.

cgf
