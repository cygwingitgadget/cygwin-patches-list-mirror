Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 0D37139DC4F5
 for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2020 15:34:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0D37139DC4F5
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N01hu-1kkJTj2AeE-00x7E4 for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2020
 17:34:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 12AB1A804E5; Fri, 17 Jul 2020 17:34:49 +0200 (CEST)
Date: Fri, 17 Jul 2020 17:34:49 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: FAQ Proposed Updates Summary and Preview Diff
Message-ID: <20200717153449.GA16360@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5dd6e092-3963-a47e-dda5-160d15b70ca0@SystematicSw.ab.ca>
 <20200717111718.GF3784@calimero.vinschen.de>
 <01553db3-9d39-ba0e-d43d-50d612e76fa9@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01553db3-9d39-ba0e-d43d-50d612e76fa9@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:QHuIWD58uyC6HJOIrfhoiH8CXeNRfLOEpC0xtEvVVrLJMKpHNHR
 paXm2jvjp6jZKXvGh7rluTilMbQab77UcewUMXcbcVI04fO5kp1Yaf+MuHNoJqJi7rx9n55
 UALZfsIYFfZIz50CvraGFaObdA/ToZ+WzOW5au8zL7vhG+S+nls3CgzwyQ1WhwuPcHbRlsQ
 GLPjkJqbv/X/PziyCN3LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y2ODaGzEv6k=:DAH9xtLRFMW+sD01BgP3e2
 S8vYKfgbPXfGuiCT4/ap/Tq46kZtBG0QXED2dPhJBUkwF5pxFuYZU1IMWHQnzwhoTk5E7kVco
 kkduD2CumC8vMQc6oA5J/NfHLtvNGEhLrwx8JWjOjOuJnNKjmXXyiA4UExFfpvJX8tYyW0lnW
 YHrT0Q6EoK9L/fSQJ1qAPHV/+C5YuoU5JJ+gYnZ7+rkU/u0eISTxaZyWcZAtAz0lG3zKqIhPD
 EsvyLrSnR3P4IFf4u77iSFJl2Mur2tGv8Br1KAJc4f6vZgM86i5l38ITXZ60JiEG4kPBg/aeI
 IrK85Qyfw3NKR1mxDVOzXardA/2R96WerjUPf8rJJb3IxcofLxFA7pKudTCNnYIleGRylATdr
 wSy6sLj0tpSWAnsf8ON8bpdS0mkd71xo49PtVaJgu+ssXeHMuGWOD2uFUG52Qkfw+Qgyort1R
 z0HXCs9L1rDPj0DwKet2LnctP+7TesmuA7ST1lem/hNhIJL5153pvtMKWRCbQvVClAoP2mqeK
 34vo9yPv28cqzHSDncUiAxA3drWD+Lkbm5tHYrgIcxVfc0PPgmwP1gblmMXx4C+rMfTD3c/t4
 2FCrV2QUHGZZOksdUTgjllNNwRSNgnIOkGM0FXtc3A9YAzKltbekI17Fe59Sd8Ss/lxmjhfoS
 lv0qagHKD8XUwqC9LEotzN2TihTBmiisWnylQEvqgKKtBOLFO/WO3JxusF7AVwUBsho3PU9ly
 ShOlAZSCBO3MOnN+tH7cZ8gzgmy3iMYHlPWgKlgFvXI4TPdZVYpqFvAeGE2scrpuDe7n2+aUM
 nwKmPnrsM3TYZzkZi1ApXgh/XM9FFFOLmGwOdNHLos7q2d0ioSHYrD0WqwCaHippAYrh7lSxf
 TcShi2ItGPyxhqOxMQPQ==
X-Spam-Status: No, score=-98.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 17 Jul 2020 15:34:52 -0000

On Jul 17 06:50, Brian Inglis wrote:
> On 2020-07-17 05:17, Corinna Vinschen wrote:
> > On Jul 16 21:35, Brian Inglis wrote:
> >> Just want to get feedback on how these FAQ changes should be packaged as patches
> >> (separate, series, single) and whether some of the changes should not be applied
> >> at all.
> 
> What about how they should be committed - by file or all in one, and
> submitted - separately by file, or as a FAQ patch series?

By theme would be preferrable.  I.e, one patch Win32 -> WinAPI, one
patch ulink changes, etc.

> >> Summary
> >>
> >> General:
> >>
> >> change setup references to use the Cygwin Setup program;
> >> change Win32 references to Windows;
> > 
> > Please, no.  At least not where Win32 refers to the API.  While this is
> > called "Windows API" these days, the word Windows alone doesn't really
> > cut it.  At leats use "Windows API" then, or IMHO even better, use the
> > informal "WinAPI" abbreviation.
> 
> Good idea - will check and change depending on context.
> 
> >> reword net release or distribution references;
> > 
> > Uhm... example?  I'm not sure what you mean here.
> 
> They look like original wording from when there were Cygnus/Red Hat
> releases and net releases: the distinction has been moot and the
> phrase not used in these lists for years.

Oh, all right.  "Cygwin distro" is the new "net distro", I guess.

> >> emphasize 64-bit Cygwin and setup-x86_64 over 32-bit;
> >> change see <ulink/> to place links around available wording;
> >> change <literal> for <filename> or <command> where appropriate;
> >> change bash .{ext1,ext2} usage to .ext1/.ext2;
> > 
> > Using comma separated lists within curly braces is the offical
> > shell way to express alternatives:
> > 
> >   $ echo a.{b,c}
> >   a.b a.c
> > 
> > Please keep them as is.
> 
> These usages are in descriptions, not in shell command contexts, and
> not used in most (POSIX) scripts, so many users will not recognize
> this convention, not even those who do some scripts but are
> inexperienced.  My fingers are trained in their use, but would use
> them in text only to other developers. ;^>

Well, most of the descriptions are written for developers in the first
place.  But, be it as it is, I don't see an advantage in using
slash-separated lists here.  Whatever you use, it's a documentation
convention and there's always somebody puzzeling over them.  Usually
you fix this by adding a "conventions in this document" chapter, but at
least the curly braces have a known meaning to devs, while something
with slashes in it typically means a path.


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
