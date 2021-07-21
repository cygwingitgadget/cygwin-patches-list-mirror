Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 151CE3857400
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 08:07:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 151CE3857400
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MelWf-1lVOs62ydp-00aork for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021
 10:07:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id EE9C2A831C6; Wed, 21 Jul 2021 10:07:50 +0200 (CEST)
Date: Wed, 21 Jul 2021 10:07:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: New tool: profiler
Message-ID: <YPfV1uOqT2WTgXVX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210716044957.5298-1-mark@maxrnd.com>
 <YPVON/D5dvOYFwfU@calimero.vinschen.de>
 <616e4815-1b8b-8c3d-0dfc-ff6c6dc6fd85@dronecode.org.uk>
 <5acddcda-7fa9-e854-911c-27af2f13a22c@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5acddcda-7fa9-e854-911c-27af2f13a22c@dronecode.org.uk>
X-Provags-ID: V03:K1:ZUvw3a0u7YmAbi5kFlcl2ROI/m9NRVA3yPI30xnY9ncYtapjWKc
 nWgIHjpNezfiBiw1jAH4uIvkwtlmWeb4VMkcqaMFogctj6dzv6AKZLbu9ZQXk46rGgO2hSV
 P0RwULYkWaOYEb2OduJtoO371xcY4OrkU7yb8wSG7SISNTckDod12OliuAHFes/fxxT8Qp3
 JVYUdOURVpsTNL6BNe6yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S+cyZk4mv0g=:i2H2QfJuBQBfbm5xNePD3c
 +OwG0R8//aSiFEYjn8SqfRA8qV7cLZjKEUC86+Xj+GmmDCnoT6xjB6wf/oWCsZML7AcmAOj2+
 VWYcCxTWfj4NiJaF9hbtbB6PTZDLYc1YZZRmZabERnQFJvQ0maJyh62/+hEdu4jVv27U/gkg1
 W9TAeD+x5wxHV3BwEy5V9HZq5MxOKeI+6O9ZwKgBmJNzdOse7akhoyc1Mk839+H+MAMqgrCIj
 pTrhb7UP3TyfBRGDoOOg+uHYYt3wOoCK3OjJ8p0ytt6P6cH8XYBm8nTkg50xhBGpQa3oNSWOq
 2MUTTcfXVdyFTQfjrWUoIdj48RAvk28HbhP/gA6pboQ0eQWfQXN165k3Hg0HUlqbc5MPW6bwh
 MCsWHsQfmDGmtwbgqyZzkYS6hyQftCCjztz552j+9/NvSyzEolK9FieQtxc9zTS3Oeg5ESa9k
 YlSTg+yY1vr+a/bqQFrpx+stjltT0W4gKHxKlXDLFHKpemodeYANkHyoZu5+bLCnlk0mDV7dt
 UfxBW6m1WSpxa75ROV+7Itf/12GGIP/W86dOk11QCFjDzXK4eagfbWohJ/mORSIWhustI7rUl
 E2dqM33YELSQiDx6JY+U8qiJXDhX7itnRGXEG1UooLzKwUBT886pbf/xBczmutUZWftS5gpxt
 aT+HQZHrtc3l0Sq0qoIVKBdT2y4lxpxsTUqaP/2qaPMrsUKQlNcFeIpFJkxYaI3CKESIDaT1E
 Mg7BSF6SmLehwfNRSfl4xTBlSz9KuZ5ybdteajOj183Xt3d1km/nJrmvkn3pUwn9TmCn9GPkO
 D1bE0MsKz1I9IXTMyt3YsDEHA0jzxxdelyQGLD60K3IVylo6rpnCjjHreAWBeyqORihcQYz0z
 mnSF+aCH/WqUM2j0vvjA==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 21 Jul 2021 08:07:55 -0000

On Jul 19 16:43, Jon Turney wrote:
> On 19/07/2021 15:23, Jon Turney wrote:
> > On 19/07/2021 11:04, Corinna Vinschen wrote:
> > > Hi Matt,
> > > 
> > > On Jul 15 21:49, Mark Geisert wrote:
> > > > The new tool formerly known as cygmon is renamed to 'profiler'.  For the
> > > > name I considered 'ipsampler' and could not think of any
> > > > others.  I'm open
> > > > to a different name if any is suggested.
> > > > 
> > > > I decided that a discussion of the pros and cons of this profiler vs the
> > > > existing ssp should probably be in the "Profiling Cygwin
> > > > Programs" section
> > > > of the Cygwin User's Guide rather than in the help for either.  That
> > > > material will be supplied at some point.
> > > > 
> > > > CONTEXT buffers are made child-specific and thus thread-specific since
> > > > there is one profiler thread for each child program being profiled.
> > > > 
> > > > The SetThreadPriority() warning comment has been expanded.
> > > > 
> > > > chmod() works on Cygwin so the "//XXX ineffective" comment is gone.
> > > > 
> > > > I decided to make the "sample all executable sections" and "sample
> > > > dynamically generated code" suggestions simply expanded comments
> > > > for now.
> > > > 
> > > > The profiler program is now a Cygwin exe rather than a native exe.
> > > 
> > > The patchset LGTM, but for the details I'd like jturney to have a look
> > > and approve it eventually.
> > 
> > Thanks.  I applied these patches.
> > 
> > A few small issues you might consider addressing in follow-ups.
> 
> It also seems there are some format warnings on x86, see
> 
> https://ci.appveyor.com/project/cygwin/cygwin/builds/40046785/job/fie6x4ta11v5nrjo

Given that we build with -Werror, these warnings are fatal.  I pushed
a patch to fix this.


Corinna
