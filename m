Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 69AC338618DF
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 15:02:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 69AC338618DF
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnqbU-1lihPX3Hy6-00pJlt for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 16:02:09 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 38B64A80D7F; Mon,  1 Feb 2021 16:02:09 +0100 (CET)
Date: Mon, 1 Feb 2021 16:02:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] CYGWIN:  Fix resolver debugging output
Message-ID: <20210201150209.GP375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210129192903.939-1-lavr@ncbi.nlm.nih.gov>
 <20210201103445.GK375565@calimero.vinschen.de>
 <DM8PR09MB7095CE3228ED706E16BA0F16A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR09MB7095CE3228ED706E16BA0F16A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
X-Provags-ID: V03:K1:ZOJEijkdWKF/VSZtWcgNl/6cahtBpvGaACFx4hH0R2mhEQNQ+EJ
 jV/kxS+Ogtx/rsB5s+yjQG0Q5Ghpk0KCqL0o/JCdSuV3SUiOXWTBnSYZJly+u/qGaA8z9EH
 cVx+/TJLFYyQ+k/aelghxQnbTLgOk0xHJ6rVeUNBnM/sXO+yyjlVxMLzsxVpgE6x/X6LTqe
 b+toL+dR9d7rxbveFPXqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F/FWEW1jUMs=:eLXftyJ6DY4xmKOCAxB121
 FSYn9+zF9SaEJU8BuDAMIJhjB50iEwanTZS8zT+kKyB9OoyIeGZGjMEeM2lnmDhr5HIxEGpxa
 8eXdcD9yauXc8DakJcYUOLOUh8HdHWARmFqhmyO/mLuaYUtmuQg1+PZjB+2QhG7ptZDpRWXQS
 gu/Phsnb2FNb439xsapBIs9vLmHE8+QdZbQYTTS7CPRe/XJ7aNX57RR+LDrwOcVJ+oVL6RIq4
 t9KgYSNvHfEyn4rPq9eb7f3Ep8MzzFSQnfsiBPTwLqQsKGjt+qiQyM3TVmQgk/4joK8d1pHRD
 E/W0zIRXAsnrFrdQbQ9KzU+nK83wvPpp7Rhgao9Y3LpJ6mXNZv+KmOC5e/G7L/9SiiXHeKM2m
 MibvLWMn3k3GWFuEdUmNlBHUdF+ddbkClhTH7t9wE9O6o63bmt/rM2lzuG7kwQK7arrFyCOhY
 lRqtP1h35w==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 01 Feb 2021 15:02:13 -0000

On Feb  1 14:23, Lavrentiev, Anton (NIH/NLM/NCBI) [C] via Cygwin-patches wrote:
> > Please use %ls, %S is non-standard.
> 
> Sure.
> 
> > For instance, write_record appears to handle DNS_TYPE_A,
> > but not DNS_TYPE_AAAA.
> 
> I can add that, it's not a problem.  But indeed, reparsing of Windows packets,
> does miss AAAA (as well as some other types, such as URI -- not sure if Windows
> has it, though).
> 
> > Would you mind to split this into a patchset with patches for different
> > tasks?  ATM I'm a bit concerned about the ntoh{sl} calls, given the
> > noticable absence of IPv6 support...
> 
> Okay.  BTW, I added ntol/s only for output of *nameserver*'s IPv4:port, because
> nameservers are IPv4 (even in glibc, AFAIK).  The _res structure (same in glibc)
> has these addresses as "struct in_addr", meaning they are IPv4.

But nameservers could be v6 addresses nevertheless, and the values are
stored in the _ext.nsaddrs member these days.  Our definition of
_res_state does not define all the members of _ext as GLibc defines,
though, and our resolver code doesn't use _ext at all, afaics.

> And so there's
> no risk of running into any troubles, but reading the IP addresses in debug output
> is much easier if they are in native order (and same goes for ports, even more).

Except, the value has no meaning for ipv6.


Corinna
