Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id 243C03858431
 for <cygwin-patches@cygwin.com>; Sat,  5 Feb 2022 23:18:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 243C03858431
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
 by cmsmtp with ESMTP
 id GL2UnAy8wyr5HGUK8nsxee; Sat, 05 Feb 2022 23:18:32 +0000
Received: from [10.0.0.5] ([184.64.124.72]) by cmsmtp with ESMTP
 id GUK8nZlzkUcbnGUK8neEaS; Sat, 05 Feb 2022 23:18:32 +0000
X-Authority-Analysis: v=2.4 cv=OO00YAWB c=1 sm=1 tr=0 ts=61ff05c8
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=x64XKuM9AAAA:8 a=94nOnFI1EgyDtX4ev68A:9
 a=QEXdDO2ut3YA:10 a=9a0SeZj3VvCmUt6k63sA:9 a=ITdVHhY7-e0A:10
 a=V64nQY_-4x5JevKAqrGb:22
Content-Type: multipart/mixed; boundary="------------3fh8aQod7rxImf9r09AXYqdo"
Message-ID: <df2f4097-35c1-78b0-3cb2-30d424fc167e@SystematicSw.ab.ca>
Date: Sat, 5 Feb 2022 16:18:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] update site goldstar award types images from jpg/png to
 webp
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20220202065958.6840-1-Brian.Inglis@SystematicSW.ab.ca>
 <YfpSaFiy7EH6BwAy@calimero.vinschen.de>
 <5d10614e-adbc-38e4-2b69-f5794d1e24c9@SystematicSw.ab.ca>
 <Yfrskl5AsCMMepFc@calimero.vinschen.de>
 <dc63c4eb-489d-be97-8f54-3aedc7645ebf@dronecode.org.uk>
 <3f2dd608-351b-c105-7191-e1992f034c9e@gmail.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <3f2dd608-351b-c105-7191-e1992f034c9e@gmail.com>
X-CMAE-Envelope: MS4xfB8MvXW+RgEBOc6uwlsJ4eWsZxDZ+s3JWk2VEa/wvP9qftov1pyC0d9+Z5taBTTy1QtCQfmgS7iUqiH8mR3b6z7whDo9Pedh7BZ9T5jTHKYU3pZ5+GBc
 AId7MCU5WjPaJ0xQQSfj1EsOWB/L3SD1/bkyteCHJuEp2olOnmkWuFBiBujYbqb8Dj38191JoJjm0mA/hArXYYMsfq4PDVHbnIk=
X-Spam-Status: No, score=-1160.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE,
 WINNER_SUBJECT autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sat, 05 Feb 2022 23:18:35 -0000

This is a multi-part message in MIME format.
--------------3fh8aQod7rxImf9r09AXYqdo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022-02-05 10:50, Marco Atzeri wrote:
> On 05.02.2022 15:26, Jon Turney wrote:
>> On 02/02/2022 20:41, Corinna Vinschen wrote:
>>> On Feb  2 11:49, Brian Inglis wrote:
>>>> On 2022-02-02 02:44, Corinna Vinschen wrote:
>>>>> On Feb  1 23:59, Brian Inglis wrote:
>> [...]
>>>>
>>>> Would you be interested in a similar patch series for the whole site?
>>
>> Do you have any information on how widespread browser support for webp 
>> is?

Sorry did not see that as my ISP outsourced spam filtering to some 
outfit which bounces mailing list messages, triggering confirm 
membership messages to me every few days from various lists.

> https://caniuse.com/webp
> It seems covered by most of recent browsers

Everything from our Qupzilla and newer, but excluding all IE 
(unsupported), and our Midori and Epiphany.

One issue I found is that our DocBook 4 does not support webp, so there 
is currently no support for webp images in generated docs from 
cygwin-apps/cygwin-x-doc, so no value in converting, unless we want to 
script an update to the image sources in the *generated* html.
This affects only cygwin-htdocs/xfree/docs/ug/figures/ ~640KB reduced to 
~195KB in the attached image summary log.
Directory summary totals are grouped at the bottom to show overall numbers.

It also looks like cygwin-htdocs/xfree/docs/ug/stylesheet-images/ and 
cygwin-htdocs/xfree/images/ are not referenced anywhere so can be rm'ed: 
checked with egrep -iR 'png|gif|bmp' cygwin-htdocs/.

So the net effect would be a reduction in image sizes from <4MB to <1MB.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
--------------3fh8aQod7rxImf9r09AXYqdo
Content-Type: text/plain; charset=UTF-8;
 name="cygwin-htdocs-images-webp-sizes.log"
Content-Disposition: attachment;
 filename="cygwin-htdocs-images-webp-sizes.log"
Content-Transfer-Encoding: base64

Y3lnd2luLWh0ZG9jcy94ZnJlZSBpbWFnZXMgcm0nZWQgb3IgY29udmVydGVkIHRvIHdlYnAK
CmRvY3MvdWcvZmlndXJlcy8KICAyNzMzMSBwbmcJCSAgMTk4OTYgd2VicAljeWkwMXdlbGNv
bWUKICAxOTk0MCBwbmcJCSAgMTE1NjQgd2VicAljeWkwMmluc3RhbGxvcHRpb24KICAzNjUy
NCBwbmcJCSAgMjQ2Njggd2VicAljeWkwM2luc3RhbGx0bwogIDIwMDU0IHBuZwkJICAxMDgx
MCB3ZWJwCWN5aTA0ZGlyZWN0b3J5CiAgMTk2OTMgcG5nCQkgIDEwNjM2IHdlYnAJY3lpMDVw
cm94eQogIDI2NjkyIHBuZwkJICAxODU0MCB3ZWJwCWN5aTA2bWlycm9yCiAgMzAwNzMgcG5n
CQkgIDI0MjA2IHdlYnAJY3lpMDdwYWNrYWdlcwogIDE3NDk4IHBuZwkJICAgOTU5MCB3ZWJw
CWN5aTA4ZG93bmxvYWRpbmcKICAxNTIxOCBwbmcJCSAgIDc5ODYgd2VicAljeWkwOWluc3Rh
bGxpbmcKICAxOTQ3NCBwbmcJCSAgMTAyNDIgd2VicAljeWkxMGNyZWF0ZWljb25zCiAxOTE3
MjEgcG5nCQkgIDE5NDM2IHdlYnAJY3l1MDFhcHBzbWVudQogIDc4NjYxIHBuZwkJICAgMzUz
MCB3ZWJwCWN5dzAxeGRtY3AKICA0OTc2NyBwbmcJCSAgIDk5NjQgd2VicAljeXcwMndtCiAg
ODY1MzIgcG5nCQkgIDE0ODc0IHdlYnAJY3l3MDNtdWx0aXdpbmRvdwogNjM5MTc4IHBuZwkJ
IDE5NTk0MiB3ZWJwCXRvdGFsCgpkb2NzL3hsYXVuY2gvCiAgICAxNTAgcG5nCQkgICAgMjIw
IHdlYnAJbW9pbi13d3cKICAgNzMwOCBibXAJCSAgICA4OTIgd2VicAlYMgogICA3NDU4IHBu
Zy9ibXAJCSAgIDExMTIgd2VicAl0b3RhbAoKc2NyZWVuc2hvdHMvCiAgMzYyNTQgcG5nCQkg
IDI0MDg2IHdlYnAJY3lneC04YnBwLW9wZW5ib3gtZGRkLWVtYWNzLTIwMDMxMjI0LTE3MjAK
IDI1OTkyNyBwbmcJCSAxNTQwOTggd2VicAljeWd4LW11bHRpd2luZG93LTIwMTUwMjAxCiAy
MzA5NjMgcG5nCQkgIDcyMDYwIHdlYnAJY3lneC1tdWx0aXdpbmRvdy1haWdseC0yMDA5MDYy
MAogIDY2MjYxIHBuZwkJICAzMDY3OCB3ZWJwCWN5Z3gtbXVsdGl3aW5kb3ctZW1hY3MtZXhp
dGNvbmZpcm0tMjAwMzEyMjQtMDAxMAogIDcwMTkxIHBuZwkJICAzMTEzOCB3ZWJwCWN5Z3gt
bXVsdGl3aW5kb3ctZW1hY3MtdHJheW1lbnUtMjAwMzEyMjQtMDAxMAogMTAzNDMzIHBuZwkJ
ICA1MzA2OCB3ZWJwCWN5Z3gtbXVsdGl3aW5kb3ctZ3YtMjAwMzEyMjQtMDAxMAogIDgwMDc1
IHBuZwkJICAzNzE1OCB3ZWJwCWN5Z3gtbXVsdGl3aW5kb3cteGZpZy1kZGQtMjAwMzEyMjQt
MDAxMAogIDY3NDcxIHBuZwkJICAyNTk1NCB3ZWJwCWN5Z3gtbm9kZWNvcmF0aW9uLW9wZW5i
b3gtZ3YteGZpZy1kZGQtMjAwMzEyMjQtMDAxMAogMTcxMzE2IHBuZwkJICA2MjUwNCB3ZWJw
CWN5Z3gtb3BlbmJveC0yMDE1MDIwMQogMTIwNDE5IHBuZwkJICA1MDU3MCB3ZWJwCWN5Z3gt
cm9vdGxlc3MtZnZ3bTItMjAwMzEyMjQtMDAxMAogMTI2NDMxIHBuZwkJICA2NTQ5OCB3ZWJw
CWN5Z3gtcm9vdGxlc3Mtb3BlbmJveC0yMDAzMTIyNC0wMDEwCiAxMzk0NzYgcG5nCQkgIDUy
MzM4IHdlYnAJY3lneC1yb290bGVzcy1XaW5kb3dNYWtlci0yMDAzMTIyNC0wMDEwCiA4NjUz
MTMgcG5nCQkgIDIyODkyIHdlYnAJY3lneC14ZG1jcC1mZWRvcmEtMjAxNTAyMDEKIDIyMjA2
NyBwbmcJCSAgOTY5MjIgd2VicAljeWd4LXhkbWNwLWtkZTMuMS0yMDAzMTIyNC0wMDEwCiA5
ODkyMTcgcG5nCQkgMTE5OTM2IHdlYnAJY3lneC14dG93LWFscGhhZGVtby0yMDEzMDgwNQoz
NTQ4ODE0IHBuZwkJIDg5ODkwMCB3ZWJwCXRvdGFsCgpzY3JlZW5zaG90cy90aHVtYnMvCiAg
MTIwMTAgcG5nCQkgICAyMDk4IHdlYnAJY3lneC04YnBwLW9wZW5ib3gtZGRkLWVtYWNzLTIw
MDMxMjI0LTE3MjAKICAxNTgwOCBwbmcJCSAgIDIzNzYgd2VicAljeWd4LW11bHRpd2luZG93
LTIwMTUwMjAxCiAgMjE0NzUgcG5nCQkgICAyNjk2IHdlYnAJY3lneC1tdWx0aXdpbmRvdy1h
aWdseC0yMDA5MDYyMAogICA5MTY5IHBuZwkJICAgMTU5MiB3ZWJwCWN5Z3gtbXVsdGl3aW5k
b3ctZW1hY3MtZXhpdGNvbmZpcm0tMjAwMzEyMjQtMDAxMAogIDExMzUzIHBuZwkJICAgMjAw
MiB3ZWJwCWN5Z3gtbXVsdGl3aW5kb3ctZW1hY3MtdHJheW1lbnUtMjAwMzEyMjQtMDAxMAog
IDExNDE3IHBuZwkJICAgMTg1NiB3ZWJwCWN5Z3gtbXVsdGl3aW5kb3ctZ3YtMjAwMzEyMjQt
MDAxMAogIDEyNDI3IHBuZwkJICAgMjI3OCB3ZWJwCWN5Z3gtbXVsdGl3aW5kb3cteGZpZy1k
ZGQtMjAwMzEyMjQtMDAxMAogIDExMTE4IHBuZwkJICAgMTc2NCB3ZWJwCWN5Z3gtbm9kZWNv
cmF0aW9uLW9wZW5ib3gtZ3YteGZpZy1kZGQtMjAwMzEyMjQtMDAxMAogIDEwMDA5IHBuZwkJ
ICAgMTQ5MCB3ZWJwCWN5Z3gtb3BlbmJveC0yMDE1MDIwMQogIDExMjQzIHBuZwkJICAgMTg4
OCB3ZWJwCWN5Z3gtcm9vdGxlc3MtZnZ3bTItMjAwMzEyMjQtMDAxMAogIDEyODc2IHBuZwkJ
ICAgMjIyNiB3ZWJwCWN5Z3gtcm9vdGxlc3Mtb3BlbmJveC0yMDAzMTIyNC0wMDEwCiAgMTE4
NTAgcG5nCQkgICAyMDAwIHdlYnAJY3lneC1yb290bGVzcy1XaW5kb3dNYWtlci0yMDAzMTIy
NC0wMDEwCiAgMTQ5NjYgcG5nCQkgICAgOTc2IHdlYnAJY3lneC14ZG1jcC1mZWRvcmEtMjAx
NTAyMDEKICAxODE0OCBwbmcJCSAgIDI5OTAgd2VicAljeWd4LXhkbWNwLWtkZTMuMS0yMDAz
MTIyNC0wMDEwCiAgMjQzNTYgcG5nCQkgICAyNjE2IHdlYnAJY3lneC14dG93LWFscGhhZGVt
by0yMDEzMDgwNQogMjA4MjI1IHBuZwkJICAzMDg0OCB3ZWJwCXRvdGFsCgoKIDYzOTE3OCBw
bmcJCSAxOTU5NDIgd2VicAlkb2NzL3VnL2ZpZ3VyZXMvCQogICA5ODI4IGdpZgkJCQlkb2Nz
L3VnL3N0eWxlc2hlZXQtaW1hZ2VzLwkoMTEpCiAgIDc0NTggcG5nL2JtcAkJICAgMTExMiB3
ZWJwCWRvY3MveGxhdW5jaC8JCQogIDIzMjI1IHBuZy9naWYJCQkJaW1hZ2VzLwkJCQkoNikK
MzU0ODgxNCBwbmcJCSA4OTg5MDAgd2VicAlzY3JlZW5zaG90cy8JCQogMjA4MjI1IHBuZwkJ
ICAzMDg0OCB3ZWJwCXNjcmVlbnNob3RzL3RodW1icy8JCgo0NDM2NzI4IHBuZy9naWYvYm1w
CTExMjY4MDIgd2VicAl0b3RhbAoK

--------------3fh8aQod7rxImf9r09AXYqdo--
