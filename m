Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id A39243858D37
 for <cygwin-patches@cygwin.com>; Wed,  2 Feb 2022 18:49:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A39243858D37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
 by cmsmtp with ESMTP
 id F88nnqS2J5Rf1FKgrnMvsi; Wed, 02 Feb 2022 18:49:13 +0000
Received: from [192.168.1.105] ([68.147.0.90]) by cmsmtp with ESMTP
 id FKgrn9cmbUcbnFKgrnRwEE; Wed, 02 Feb 2022 18:49:13 +0000
X-Authority-Analysis: v=2.4 cv=OO00YAWB c=1 sm=1 tr=0 ts=61fad229
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
 a=7728-0jicxn743IMRG0A:9 a=m-Z_27IZkzAA:10
Content-Type: multipart/mixed; boundary="------------00fujIM7pr6NrV1zIOxIb2pO"
Message-ID: <5d10614e-adbc-38e4-2b69-f5794d1e24c9@SystematicSw.ab.ca>
Date: Wed, 2 Feb 2022 11:49:12 -0700
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
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <YfpSaFiy7EH6BwAy@calimero.vinschen.de>
X-CMAE-Envelope: MS4xfE+n1lcEGirf5X5fvX3HncFq1OjwEDezbzeFnE6Qsf17iBrLzN5T7+/PLjUKlK+36CnqDq0eH2du8rH/UqErUOGRQYJ1twI9xQCeXHy1a7+E5MH/yvel
 q6pziG0xhsZz7nkTdE+j7Cm5eUA1jHJpXJqVs2035sOre9rYuvSpXdXnnuzhjitwG9xF8YKvThrKNs8NOmzd2jPr5nhqeXWR4Ik=
X-Spam-Status: No, score=-1158.9 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE, TXREP,
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
X-List-Received-Date: Wed, 02 Feb 2022 18:49:16 -0000

This is a multi-part message in MIME format.
--------------00fujIM7pr6NrV1zIOxIb2pO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-02-02 02:44, Corinna Vinschen wrote:
> On Feb  1 23:59, Brian Inglis wrote:
>> Our images at cygwin-htdocs/goldstars/img/ seemed large for small icons:
>>
>> $ wc -c img/*
>>    3473 img/dungbomb.png
>>    1074 img/goldstar.png
>>    1303 img/goldwatch.png
>>    9382 img/pinkwatch.jpg
>>     877 img/platinumwatch.jpg
>>     878 img/plush_hippo.jpg
>>    1055 img/silverstar.png
>>   18042 total
>>
>> so converted them and found they were much smaller in webp format,
>> and reconverting using the upgraded libwebp package command:
>>
>>      $ cwebp -blend_alpha 0xffffff img/$i.* -o images/$i.webp
>>
>> $ wc -c images/*
>>    220 images/dungbomb.webp
>>    284 images/goldstar.webp
>>    286 images/goldwatch.webp
>>    322 images/pinkwatch.webp
>>    232 images/platinumwatch.webp
>>    204 images/plush_hippo.webp
>>    174 images/silverstar.webp
>>   1722 total
>>
>> Updating these would make the site more mobile friendly,
>> quicker for those on low-bandwidth connections,
>> and cheaper for those on expensive plans.
> 
> Nice, pushed with a remade index.html.

Great, thanks.

Would you be interested in a similar patch series for the whole site?

Please see attached for images, sizes, and paths.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
--------------00fujIM7pr6NrV1zIOxIb2pO
Content-Type: text/plain; charset=UTF-8;
 name="cygwin-htdocs-images-webp-sizes.txt"
Content-Disposition: attachment;
 filename="cygwin-htdocs-images-webp-sizes.txt"
Content-Transfer-Encoding: base64

ICAgIEltYWdlcwkgIFdlYnAJCUJhc2VuYW1lCQkJCQkJUGF0aAogNzg2NjEJLnBuZwkgIDM1
MzAJLndlYnAJY3l3MDF4ZG1jcAkJCQkJCWN5Z3dpbi1odGRvY3MveGZyZWUvZG9jcy91Zy9m
aWd1cmVzCiAxNTIxOAkucG5nCSAgNzk4Ngkud2VicAljeWkwOWluc3RhbGxpbmcJCQkJCQlj
eWd3aW4taHRkb2NzL3hmcmVlL2RvY3MvdWcvZmlndXJlcwogMTc0OTgJLnBuZwkgIDk1OTAJ
LndlYnAJY3lpMDhkb3dubG9hZGluZwkJCQkJY3lnd2luLWh0ZG9jcy94ZnJlZS9kb2NzL3Vn
L2ZpZ3VyZXMKIDQ5NzY3CS5wbmcJICA5OTY0CS53ZWJwCWN5dzAyd20JCQkJCQkJY3lnd2lu
LWh0ZG9jcy94ZnJlZS9kb2NzL3VnL2ZpZ3VyZXMKIDE5NDc0CS5wbmcJIDEwMjQyCS53ZWJw
CWN5aTEwY3JlYXRlaWNvbnMJCQkJCWN5Z3dpbi1odGRvY3MveGZyZWUvZG9jcy91Zy9maWd1
cmVzCiAxOTY5MwkucG5nCSAxMDYzNgkud2VicAljeWkwNXByb3h5CQkJCQkJY3lnd2luLWh0
ZG9jcy94ZnJlZS9kb2NzL3VnL2ZpZ3VyZXMKIDIwMDU0CS5wbmcJIDEwODEwCS53ZWJwCWN5
aTA0ZGlyZWN0b3J5CQkJCQkJY3lnd2luLWh0ZG9jcy94ZnJlZS9kb2NzL3VnL2ZpZ3VyZXMK
IDE5OTQwCS5wbmcJIDExNTY0CS53ZWJwCWN5aTAyaW5zdGFsbG9wdGlvbgkJCQkJY3lnd2lu
LWh0ZG9jcy94ZnJlZS9kb2NzL3VnL2ZpZ3VyZXMKIDg2NTMyCS5wbmcJIDE0ODc0CS53ZWJw
CWN5dzAzbXVsdGl3aW5kb3cJCQkJCWN5Z3dpbi1odGRvY3MveGZyZWUvZG9jcy91Zy9maWd1
cmVzCiAyNjY5MgkucG5nCSAxODU0MAkud2VicAljeWkwNm1pcnJvcgkJCQkJCWN5Z3dpbi1o
dGRvY3MveGZyZWUvZG9jcy91Zy9maWd1cmVzCjE5MTcyMQkucG5nCSAxOTQzNgkud2VicAlj
eXUwMWFwcHNtZW51CQkJCQkJY3lnd2luLWh0ZG9jcy94ZnJlZS9kb2NzL3VnL2ZpZ3VyZXMK
IDI3MzMxCS5wbmcJIDE5ODk2CS53ZWJwCWN5aTAxd2VsY29tZQkJCQkJCWN5Z3dpbi1odGRv
Y3MveGZyZWUvZG9jcy91Zy9maWd1cmVzCiAzMDA3MwkucG5nCSAyNDIwNgkud2VicAljeWkw
N3BhY2thZ2VzCQkJCQkJY3lnd2luLWh0ZG9jcy94ZnJlZS9kb2NzL3VnL2ZpZ3VyZXMKIDM2
NTI0CS5wbmcJIDI0NjY4CS53ZWJwCWN5aTAzaW5zdGFsbHRvCQkJCQkJY3lnd2luLWh0ZG9j
cy94ZnJlZS9kb2NzL3VnL2ZpZ3VyZXMKICAgIDk1CS5naWYJICAgIDU0CS53ZWJwCXRvYy1i
bGFuawkJCQkJCWN5Z3dpbi1odGRvY3MveGZyZWUvZG9jcy91Zy9zdHlsZXNoZWV0LWltYWdl
cwogICA4NDMJLmdpZgkgICAgNzYJLndlYnAJdG9jLW1pbnVzCQkJCQkJY3lnd2luLWh0ZG9j
cy94ZnJlZS9kb2NzL3VnL3N0eWxlc2hlZXQtaW1hZ2VzCiAgIDg0NgkuZ2lmCSAgICA4MAku
d2VicAl0b2MtcGx1cwkJCQkJCWN5Z3dpbi1odGRvY3MveGZyZWUvZG9jcy91Zy9zdHlsZXNo
ZWV0LWltYWdlcwogICA5MjIJLmdpZgkgICAxNTYJLndlYnAJdXAJCQkJCQkJY3lnd2luLWh0
ZG9jcy94ZnJlZS9kb2NzL3VnL3N0eWxlc2hlZXQtaW1hZ2VzCiAgIDk0NAkuZ2lmCSAgIDE3
NAkud2VicAlwcmV2CQkJCQkJCWN5Z3dpbi1odGRvY3MveGZyZWUvZG9jcy91Zy9zdHlsZXNo
ZWV0LWltYWdlcwogICA5NjQJLmdpZgkgICAxOTAJLndlYnAJbmV4dAkJCQkJCQljeWd3aW4t
aHRkb2NzL3hmcmVlL2RvY3MvdWcvc3R5bGVzaGVldC1pbWFnZXMKICAgOTk1CS5naWYJICAg
MjAwCS53ZWJwCWhvbWUJCQkJCQkJY3lnd2luLWh0ZG9jcy94ZnJlZS9kb2NzL3VnL3N0eWxl
c2hlZXQtaW1hZ2VzCiAgMTAyOQkuZ2lmCSAgIDIwOAkud2VicAl0aXAJCQkJCQkJY3lnd2lu
LWh0ZG9jcy94ZnJlZS9kb2NzL3VnL3N0eWxlc2hlZXQtaW1hZ2VzCiAgMTA3MAkuZ2lmCSAg
IDI0MAkud2VicAlub3RlCQkJCQkJCWN5Z3dpbi1odGRvY3MveGZyZWUvZG9jcy91Zy9zdHls
ZXNoZWV0LWltYWdlcwogIDEwMzkJLmdpZgkgICAzMjgJLndlYnAJY2F1dGlvbgkJCQkJCQlj
eWd3aW4taHRkb2NzL3hmcmVlL2RvY3MvdWcvc3R5bGVzaGVldC1pbWFnZXMKICAxMDUyCS5n
aWYJICAgMzMwCS53ZWJwCXdhcm5pbmcJCQkJCQkJY3lnd2luLWh0ZG9jcy94ZnJlZS9kb2Nz
L3VnL3N0eWxlc2hlZXQtaW1hZ2VzCiAgMTA4MQkuZ2lmCSAgIDM2Mgkud2VicAlpbXBvcnRh
bnQJCQkJCQljeWd3aW4taHRkb2NzL3hmcmVlL2RvY3MvdWcvc3R5bGVzaGVldC1pbWFnZXMK
ICA3MzA4CS5ibXAJICAgODkyCS53ZWJwCVgyCQkJCQkJCWN5Z3dpbi1odGRvY3MveGZyZWUv
ZG9jcy94bGF1bmNoCiAgIDE1MAkucG5nCSAgIDIyMAkud2VicAltb2luLXd3dwkJCQkJCWN5
Z3dpbi1odGRvY3MveGZyZWUvZG9jcy94bGF1bmNoCiAgICA1MAkuZ2lmCSAgICA0MAkud2Vi
cAlibGFja0xpbmVzCQkJCQkJY3lnd2luLWh0ZG9jcy94ZnJlZS9pbWFnZXMKIDE1ODgwCS5w
bmcJICAgODY0CS53ZWJwCXhpbWFnZQkJCQkJCQljeWd3aW4taHRkb2NzL3hmcmVlL2ltYWdl
cwogIDExMzQJLnBuZwkgIDExMDAJLndlYnAJdmNzcwkJCQkJCQljeWd3aW4taHRkb2NzL3hm
cmVlL2ltYWdlcwogICA3OTkJLnBuZwkgIDEyMDgJLndlYnAJdmFsaWQtaHRtbDQwCQkJCQkJ
Y3lnd2luLWh0ZG9jcy94ZnJlZS9pbWFnZXMKICAyOTQ4CS5wbmcJICAxMjM4CS53ZWJwCXZh
bGlkLWh0bWw0MDEJCQkJCQljeWd3aW4taHRkb2NzL3hmcmVlL2ltYWdlcwogIDI0MTQJLnBu
ZwkgIDEyNjIJLndlYnAJdmFsaWQteGh0bWwxMAkJCQkJCWN5Z3dpbi1odGRvY3MveGZyZWUv
aW1hZ2VzCiAxNDk2NgkucG5nCSAgIDk3Ngkud2VicAljeWd4LXhkbWNwLWZlZG9yYS0yMDE1
MDIwMQkJCQljeWd3aW4taHRkb2NzL3hmcmVlL3NjcmVlbnNob3RzL3RodW1icwogMTAwMDkJ
LnBuZwkgIDE0OTAJLndlYnAJY3lneC1vcGVuYm94LTIwMTUwMjAxCQkJCQljeWd3aW4taHRk
b2NzL3hmcmVlL3NjcmVlbnNob3RzL3RodW1icwogIDkxNjkJLnBuZwkgIDE1OTIJLndlYnAJ
Y3lneC1tdWx0aXdpbmRvdy1lbWFjcy1leGl0Y29uZmlybS0yMDAzMTIyNC0wMDEwCWN5Z3dp
bi1odGRvY3MveGZyZWUvc2NyZWVuc2hvdHMvdGh1bWJzCiAxMTExOAkucG5nCSAgMTc2NAku
d2VicAljeWd4LW5vZGVjb3JhdGlvbi1vcGVuYm94LWd2LXhmaWctZGRkLTIwMDMxMjI0LTAw
MTAJY3lnd2luLWh0ZG9jcy94ZnJlZS9zY3JlZW5zaG90cy90aHVtYnMKIDExNDE3CS5wbmcJ
ICAxODU2CS53ZWJwCWN5Z3gtbXVsdGl3aW5kb3ctZ3YtMjAwMzEyMjQtMDAxMAkJCWN5Z3dp
bi1odGRvY3MveGZyZWUvc2NyZWVuc2hvdHMvdGh1bWJzCiAxMTI0MwkucG5nCSAgMTg4OAku
d2VicAljeWd4LXJvb3RsZXNzLWZ2d20yLTIwMDMxMjI0LTAwMTAJCQljeWd3aW4taHRkb2Nz
L3hmcmVlL3NjcmVlbnNob3RzL3RodW1icwogMTE4NTAJLnBuZwkgIDIwMDAJLndlYnAJY3ln
eC1yb290bGVzcy1XaW5kb3dNYWtlci0yMDAzMTIyNC0wMDEwCQkJY3lnd2luLWh0ZG9jcy94
ZnJlZS9zY3JlZW5zaG90cy90aHVtYnMKIDExMzUzCS5wbmcJICAyMDAyCS53ZWJwCWN5Z3gt
bXVsdGl3aW5kb3ctZW1hY3MtdHJheW1lbnUtMjAwMzEyMjQtMDAxMAkJY3lnd2luLWh0ZG9j
cy94ZnJlZS9zY3JlZW5zaG90cy90aHVtYnMKIDEyMDEwCS5wbmcJICAyMDk4CS53ZWJwCWN5
Z3gtOGJwcC1vcGVuYm94LWRkZC1lbWFjcy0yMDAzMTIyNC0xNzIwCQljeWd3aW4taHRkb2Nz
L3hmcmVlL3NjcmVlbnNob3RzL3RodW1icwogMTI4NzYJLnBuZwkgIDIyMjYJLndlYnAJY3ln
eC1yb290bGVzcy1vcGVuYm94LTIwMDMxMjI0LTAwMTAJCQljeWd3aW4taHRkb2NzL3hmcmVl
L3NjcmVlbnNob3RzL3RodW1icwogMTI0MjcJLnBuZwkgIDIyNzgJLndlYnAJY3lneC1tdWx0
aXdpbmRvdy14ZmlnLWRkZC0yMDAzMTIyNC0wMDEwCQkJY3lnd2luLWh0ZG9jcy94ZnJlZS9z
Y3JlZW5zaG90cy90aHVtYnMKIDE1ODA4CS5wbmcJICAyMzc2CS53ZWJwCWN5Z3gtbXVsdGl3
aW5kb3ctMjAxNTAyMDEJCQkJY3lnd2luLWh0ZG9jcy94ZnJlZS9zY3JlZW5zaG90cy90aHVt
YnMKIDI0MzU2CS5wbmcJICAyNjE2CS53ZWJwCWN5Z3gteHRvdy1hbHBoYWRlbW8tMjAxMzA4
MDUJCQkJY3lnd2luLWh0ZG9jcy94ZnJlZS9zY3JlZW5zaG90cy90aHVtYnMKIDIxNDc1CS5w
bmcJICAyNjk2CS53ZWJwCWN5Z3gtbXVsdGl3aW5kb3ctYWlnbHgtMjAwOTA2MjAJCQkJY3ln
d2luLWh0ZG9jcy94ZnJlZS9zY3JlZW5zaG90cy90aHVtYnMKIDE4MTQ4CS5wbmcJICAyOTkw
CS53ZWJwCWN5Z3gteGRtY3Ata2RlMy4xLTIwMDMxMjI0LTAwMTAJCQkJY3lnd2luLWh0ZG9j
cy94ZnJlZS9zY3JlZW5zaG90cy90aHVtYnMKODg4OTY2CQkyMzYwMTIJCVRvdGFsCg==

--------------00fujIM7pr6NrV1zIOxIb2pO--
