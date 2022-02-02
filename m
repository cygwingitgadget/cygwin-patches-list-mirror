Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id C78163857C72
 for <cygwin-patches@cygwin.com>; Wed,  2 Feb 2022 07:00:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C78163857C72
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id F6zfnqPLl5Rf1F9cdnL9iJ; Wed, 02 Feb 2022 07:00:07 +0000
Received: from BWINGLISD.shawcable.net. ([68.147.0.90]) by cmsmtp with ESMTP
 id F9ccneuqtNat4F9cdnFlSa; Wed, 02 Feb 2022 07:00:07 +0000
X-Authority-Analysis: v=2.4 cv=e9cV9Il/ c=1 sm=1 tr=0 ts=61fa2bf7
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=L0ST7ytl6p3gQLmE4EgA:9 a=BPFFM60tbmFlLWb5:21
 a=QEXdDO2ut3YA:10 a=alyYY8cFY9-tDUBdOBsA:9 a=Us49UQ1DcwGNiPdI:21
 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: "Cygwin Patches" <cygwin-patches@cygwin.com>
Subject: [PATCH] update site goldstar award types images from jpg/png to webp
Date: Tue,  1 Feb 2022 23:59:58 -0700
Message-Id: <20220202065958.6840-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.34.1"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJRw6Z0BoDHByeuvmYDtrOXRSyjHOwLYOzoIDmzF2GETdi5CmFQRpk9uQxXwS6JudzJuyxX2QWlPdAuk/4PBZgVPI91ZTJddzG+xmwqFbCdBbv9FHqv1
 0YHcFZrbyuagOBVmCuzTQlRdCt2hjeyCfevKi6rtZYn8b341xcknUWOFU+jFn2DV5ydxfsgoOFuKUpujalUQUihmemmezvNSXV1cRp1Qu6p2LNqyZyoZ5QU6
 LERlbQvhuueG4fiz3fiaeIaN3Nx5dG5sibtgcmXTPkY=
X-Spam-Status: No, score=-1156.2 required=5.0 tests=BAYES_50, GIT_PATCH_0,
 IMAGE_ATTACHED, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_LOTSOFHASH,
 LOTS_OF_MONEY, RCVD_IN_BARRACUDACENTRAL, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_NONE, TXREP, T_HK_SPAMMY_FILENAME, T_SCC_BODY_TEXT_LINE,
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
X-List-Received-Date: Wed, 02 Feb 2022 07:00:11 -0000

This is a multi-part message in MIME format.
--------------2.34.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

Our images at cygwin-htdocs/goldstars/img/ seemed large for small icons:

$ wc -c img/*
  3473 img/dungbomb.png
  1074 img/goldstar.png
  1303 img/goldwatch.png
  9382 img/pinkwatch.jpg
   877 img/platinumwatch.jpg
   878 img/plush_hippo.jpg
  1055 img/silverstar.png
 18042 total

so converted them and found they were much smaller in webp format,
and reconverting using the upgraded libwebp package command:

    $ cwebp -blend_alpha 0xffffff img/$i.* -o images/$i.webp

$ wc -c images/*
  220 images/dungbomb.webp
  284 images/goldstar.webp
  286 images/goldwatch.webp
  322 images/pinkwatch.webp
  232 images/platinumwatch.webp
  204 images/plush_hippo.webp
  174 images/silverstar.webp
 1722 total

Updating these would make the site more mobile friendly,
quicker for those on low-bandwidth connections,
and cheaper for those on expensive plans.

---
 goldstars/img/dungbomb.png       | Bin 3473 -> 0 bytes
 goldstars/img/dungbomb.webp      | Bin 0 -> 220 bytes
 goldstars/img/goldstar.png       | Bin 1074 -> 0 bytes
 goldstars/img/goldstar.webp      | Bin 0 -> 284 bytes
 goldstars/img/goldwatch.png      | Bin 1303 -> 0 bytes
 goldstars/img/goldwatch.webp     | Bin 0 -> 286 bytes
 goldstars/img/pinkwatch.jpg      | Bin 9382 -> 0 bytes
 goldstars/img/pinkwatch.webp     | Bin 0 -> 322 bytes
 goldstars/img/platinumwatch.jpg  | Bin 877 -> 0 bytes
 goldstars/img/platinumwatch.webp | Bin 0 -> 232 bytes
 goldstars/img/plush_hippo.jpg    | Bin 878 -> 0 bytes
 goldstars/img/plush_hippo.webp   | Bin 0 -> 204 bytes
 goldstars/img/silverstar.png     | Bin 1055 -> 0 bytes
 goldstars/img/silverstar.webp    | Bin 0 -> 174 bytes
 goldstars/src/award_types.csv    |  14 +++++++-------
 15 files changed, 7 insertions(+), 7 deletions(-)
 delete mode 100644 goldstars/img/dungbomb.png
 create mode 100644 goldstars/img/dungbomb.webp
 delete mode 100644 goldstars/img/goldstar.png
 create mode 100644 goldstars/img/goldstar.webp
 delete mode 100644 goldstars/img/goldwatch.png
 create mode 100644 goldstars/img/goldwatch.webp
 delete mode 100755 goldstars/img/pinkwatch.jpg
 create mode 100644 goldstars/img/pinkwatch.webp
 delete mode 100644 goldstars/img/platinumwatch.jpg
 create mode 100644 goldstars/img/platinumwatch.webp
 delete mode 100644 goldstars/img/plush_hippo.jpg
 create mode 100644 goldstars/img/plush_hippo.webp
 delete mode 100644 goldstars/img/silverstar.png
 create mode 100644 goldstars/img/silverstar.webp


--------------2.34.1
Content-Type: text/x-patch; name="0001-update-site-goldstar-award-type-images-from-jpg-png-to-webp.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-update-site-goldstar-award-type-images-from-jpg-png-to-webp.patch"

diff --git a/goldstars/img/dungbomb.png b/goldstars/img/dungbomb.png
deleted file mode 100644
index 4c2c0b52077f77c0d335562262666cd946f2eefa..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 3473
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

diff --git a/goldstars/img/dungbomb.webp b/goldstars/img/dungbomb.webp
new file mode 100644
index 0000000000000000000000000000000000000000..a5e8de0933ce00c9270c0415ce8096e7259076d3
GIT binary patch
literal 220
zcmV<203-iWNk&H000012MM6+kP&gpS0000m1OS}@Dh~h?06vj8mq(?eA|Wsc0I(7X
zW&oW5i#FQr{OPY8^9VM<3;_Q1SaEH({dXIU_c61mvbrmps($xp;oUO-(ou7^R!wK-
zkqOVlg0fYw^OC#r*k-Nj-#r@y`_8RCIGp|QR6|0v-<cjtTWJLTOGI9}TYmYC2KW_|
zhbMW++6pmMt1b>EvzJja4%Xi`u!Ec$(bQTb<6Az1;AlHN_!GbOi~m=CmIrz}pro0*
W?gcE@SL)S0;fwr45<lTKYybd0wPfG`

literal 0
HcmV?d00001

diff --git a/goldstars/img/goldstar.png b/goldstars/img/goldstar.png
deleted file mode 100644
index 8c6a1f2f5f03753362e9c849461a7acd062daa20..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1074
zcmV-21kL-2P)<h;3K|Lk000e1NJLTq000vJ000vR1^@s6a!@wR00006VoOIv0RI60
z0RN!9r;`8x010qNS#tmY3ljhU3ljkVnw%H_000McNliru-v|>71UmK_QaAtr1HVZ`
zK~y-)m6KbDlw}ylfA4piL#wmnG`s7zZENESnz(A-SO!r-BpvWtP)NJj3yHdlA}Gw8
zA`G(wVNsDwWOv<ExL)KTP%$KO)7gW~?zrpD>dx_-@0;&Ebg>u;jnMz{d7j^&=fDGP
z6kR(6fSx(BQx`wJpl3eX2@p+v&<;Ux56Qye3|{9IJN-mPFPtbDBL|$mVZU9y^<Tl@
z^4kEYp!T_y9Lz+ubC7s2s~d9%0D`dt{4e>x@6V~?NEF^WW`g2MQytr4S`(jy#c$hB
zW3@|Y?Y>7x&N1dXvEIK3%Qq38bUW9*`Tjk37XJFKU5_s3L@b-J?D(K<JF8+nL$9>N
zg>*9WBEl8u<_Pm=kC9pZR;5)94k_K5K$^Ug)y4Fhz2l;5y%x7lz4nf9TQ4LsLn)=^
zlBh;jJJQ1Q@e*;o^e#;6GQtU|T|G#n(87!NV#l(|POK=|Znxj8R;xyP$3-~tx^^=g
zg_0#S5@RWBBM?ps+fHFr0Qx$@6fu^Iu8k2aUO`q$_%}l0i2*v-Y$8}x#;H$Fms5#Y
zx>optj=^EP_<D$LfmuYiX2CQ-H!!VfKw-H_lHFSny)6>`b!LuVWLbYe<EAKy!gtR-
z<1M$3Eb9wbH!DAr?0S+!b_f;vpnZ(-5k`Vq0Ie{Q#CD-FS;8;QvaD|t^;-9YjNCl}
zVDhW&o1K{TW6uWNTP>X>-q}Oq{v0M!DA_<n5xUhtNQtlnwPKY<u}pT|5c4yg*R`~t
zU$y(Ei{jeXPcyJ*l*uo*4asJ7wtsCcxscD3&ZV&21YkhRe~)jBraV<<MJ~tmSjx9N
z=ds-0Q<wh!W;@ovo>3-_KF-50oxY^Bexo|OG=^zLsCoq*35<5p(nd9XRHKOyn##09
zO8Ihb@2N`@N4N3N?h`lwxqWArelhU7Q30wMVc8zmiq$yxC5h@)ypH9ldKI}ig=$to
zgvh|}TH;RwEScSw3WLpdRK_Uq`Zf^W7-#m(ELulcj!W0Zeqs-7z>J^7)n!!ZJPUky
zo4?B}YBaaSdo;~F%>FWp6c*Vv9e9c5w3;pEFHYhxj<6x#qlog&NAKkCGIMpqIFTfl
zjbVEZ#)&ca2Y;64tbBH*Gnii6`G|-@R4DPZ#+H7p?W4yCJ-1sRM2wqL*46x|87|C3
zJGLI4-&rU`JMt&Y@WPaJ)pBDvT?W?#Ufa%Uksdk!1G{WXzZwP3v8_iI%K#_$rFiPo
sN&)!nxBbcQD<!p0pECzBjNHlp185uJwgG_?kpKVy07*qoM6N<$f-+M6UjP6A

diff --git a/goldstars/img/goldstar.webp b/goldstars/img/goldstar.webp
new file mode 100644
index 0000000000000000000000000000000000000000..181d6136290a59ca0c891d7e52a09db222a7cc9e
GIT binary patch
literal 284
zcmV+%0ptEsNk&E#0RRA3MM6+kP&gn60RRB-1^}G_DiZ(`06vjEnMtLiA|WUWsIU?V
zYyh1ygm~}Z`)881+dHw{=TahozC}e=Up!LVWj^;apkShq>BqnT{`;vyyh}JS6VZdL
zn9=KD3?M?4zQJlHF9AybA3B3a!bPVar|vLhf0~c2k*(#d0z$fUa!=P8S2MC%)|12M
z#U)>Rbv!^zJYCqoHN1MR?`~CQydaSeXXqHr@A^=!91r=UT)noVw`PWVn>X<7+2wYW
zT~qVC)$5jlbYbR*?0}7<un5qsiM|l&M=D5tSZO`S$KmQA;7!OcSSV@1*JI3O0eOhE
io_-E18_OWuKL%f$4qI@=`uBgj4lPf+KzuR+KmY(aw1UC_

literal 0
HcmV?d00001

diff --git a/goldstars/img/goldwatch.png b/goldstars/img/goldwatch.png
deleted file mode 100644
index a0e8b3c323bb8a5c2048ada78cb376542cd65db8..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1303
zcmV+y1?c*TP)<h;3K|Lk000e1NJLTq000>P000vR0ssI2>JTwf00001b5ch_0Itp)
z=>Px#32;bRa{vGf6951U69E94oEQKA00(qQO+^RV2@Vk$51szZBme*esYygZR5;6Z
zl*?~absWWi&$-We+}loH(`h?Eg+f~kEwxBg0umC9Q4^!YrO|}Mg^7=a?p+#}u1$2K
z34#w2Bq17UARqz9c3N5(I@3-&od=!go%{TKT~t}g`2#*VCpqU}&#@WmSoJDa!c>hD
z1Ox>r@R9I^?}2bQlYnvr2vdxhh7d+i5Tm}`E<MOD-0mLPA0O)?zFo~PKV15|R&Qc1
z$7CW90WKwyL;a~?rmF})k%ggN%HF)(D(71PIehx9-!EOr+@3!&HEH%F<cO*2I-|VS
zXcRXK&06K@V<(c6$1x%Q@5^^=;n<GVxOwB&y?YPaj+fYb&>S8&<9&tAVu!JKJRS+f
zyZ}AgE`I&x=Wm?*c<k7V2;i|n0KgdUvK-fOkU$`Wu1JHUliWyJN<6Ifx{@uhO2hHW
z=6d(Qh{DLdO!~^VUnyF6cw+W(RE+U1j(+;VIcqyh11oA8k)eYF!;`j)G%cj7JgVt2
z!@vkp!em8fYQ*SIrWfx9`PF^X$C<1M-}SAg@NB>o6GA_E|Gic*XE&;0)2!O0RP78V
zQ+h-d!e3pvUo4l5n4!w52t@W_R@1c*=EcQKB&K(#4%ACqzkc(@o!>4ti(84*DE;u<
zJ5IG=)yrmY|9aKpQmoc&Gfq`ijztZ_G$bxnDiz0e!Vx`Y##B9=UtXfjADy1wTuf^!
zI(q61p_<jS7)FQ?0sxNV7=}48H0lawdChvgrYjKwkXy?>sx}T!Pg9CoRvlErqoKQZ
zukXKosB&j1x4zo)@WkAy<@6Gxlm>zCx?ZJJS}AY!B*wX<m|-&r+*~f#wi;t&6Uo65
zgirveuvH96L5T3Bh0HJKFSb?-n$GCf)+7ild`3B^j0=E`{JPrp6v6*?hjZTF*Vpdo
zlv0cYKmY;_4UI6Ty-6d74jz5?qtC8>ccHs4)<1qIaBW4Eh(}pV;HF2f|Cy;Zy-KYL
zBmlsUWlNk;*=Sg<A2<|T@a^qF9$6a=x3*_uE@UJpUU{|dQJLyX3z@{eQ6gjDm^uNw
zareQ-Rw=!has9v-$Ol40GBnB>MSegXqLk})tz{S1^W{gC@tGNcS>NEu%yTE}Eqniw
znOMA+Nt_Z9c!D~>R6YF6>?|X=-EL9F1>q8Bm1;d?$U&#sV?<-bzH<Htrs;bp$1x%T
zNTg>V)}QbN2uca#G63d;$c(Nm{N=TFh}&*fifV{iR;P(nt*ehy<kkwfmS3L#xmwwI
z`Rv<7mH>cYDj4@EM?54jB}fT#U00cRdTuPr+&h0<?v&P&rmSEGT&vOC(U@z}hDmBG
z>G|CH+6yneo|>9<2}6jGK=>ep5JVsXfIZKyW#-dYzK?23d~ELWPd`eMG_+^5JCQ<M
zLEtmL<<z(DXR{kSos+Mf9iM)|W5gp=5tszRW&suu0)jBYf$xJ=TD^9OA~bU1O~2Dx
zxOFXk{i@%r>Jnj;w%q{a$mrCwQ_r7~qdkmZKnO6x0uTToKnTe0y#2tV!m>+ip4HYz
z4kH9Xr(VgeRB|h|YMEfH$GT#PRB!5l6gB~Kz-0GY0pP!<0E`g;`~x~1Y09$skP`p^
N002ovPDHLkV1j{|Vo3l1

diff --git a/goldstars/img/goldwatch.webp b/goldstars/img/goldwatch.webp
new file mode 100644
index 0000000000000000000000000000000000000000..31d4afce0c119084ec0a4546fa93327d842d7040
GIT binary patch
literal 286
zcmV+(0pb2qNk&E%0RRA3MM6+kP&gn80RR9n1^}G_Dj5J106vjGnMtLiq9G^>sIU?V
zKoh1=XYS3I-q*k(!@tuip0Fl0xBN)ZHGiYbs)qlR0092<5@xklt|MQRZ`xp9xei0`
zHZqU7?BHu9^ofw-jaYoA;NSBM_Lw-EO6B*F>B{6Yt(u8@(v5qqvE|hhO(h_MIh%KK
zelQ>lv@;m%EBU~ys2m&TluhxSPt#SW-@$oRqE<EkZD_9MTKP#e+P&yUOk*v$(U(Nw
zpwxMLyVooT1{^Zq@1VQkA`j4<cgM^f!YfBeHmLsnO6b=cGm7Xf-dc9xg2xk<{nKpe
kq8m_a068{^4Wi+u*dxb751`R65P9XYspNHN=n4P;02dL7CjbBd

literal 0
HcmV?d00001

diff --git a/goldstars/img/pinkwatch.jpg b/goldstars/img/pinkwatch.jpg
deleted file mode 100755
index c98712c98a7eea9e54b467d0b28d25a7501dd970..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 9382
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

diff --git a/goldstars/img/pinkwatch.webp b/goldstars/img/pinkwatch.webp
new file mode 100644
index 0000000000000000000000000000000000000000..7c908e17f2acb13d9ea40a5cca181c9a806cade6
GIT binary patch
literal 322
zcmV-I0lofGNk&FG0RRA3MM6+kP&gni0RR9H1^}G_Djfh506vjEnMtLiA|WUWsIU?V
zWB{x)WKIFnVWByN>mtnBXrW&R6;L9`lisOEVvDF?0RHxUo}Ep;qMb3praEnZ@RcOy
zx{u<e&}wLHV{VoJ*1?5E@~$Kre90PH;!_&}9{ZTmVYFmnJEpf=vk#^3i+`0>%1Ib;
zTWCHmI9^4iF%4AH1oA&LHR0Oc0Xw_I1Te<JSx@-k9*ZaXxpExf@~=;rH9yTh;9X!X
z)4&D_OrFWXRQP$ts4^Y7mQS_c*`>=C6G4S};;x9tdeo_Vx5M^sqM6tIyh&e2jkj3C
zIWa;TOR;gYKdkuPZlXKASCNBaQOf#bDu|EZ3j%><1baQ1?KHw25HMOjv9x6mn)|*P
U+OmkSo@3$7sQP-v{@j+h0K)B-0ssI2

literal 0
HcmV?d00001

diff --git a/goldstars/img/platinumwatch.jpg b/goldstars/img/platinumwatch.jpg
deleted file mode 100644
index 1a7fb5c67fd0b85c1dd5c43ca426473dd9f4d060..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 877
zcmex=<NpH&0WUXCHwH#VMur3+WcYuZ!I^=Xi3x;&fCY$HIapa)SXjB(+1WUFxOjND
zxwyG``Gf>``2_j6xdp@o1cgOJMMZh|#U;c<B!omnML>oyG6VInuyV4pa*FVB^NNrR
z{vTox<X{kHkY#2RWMC3xWEN!ne}qAbfq{{gkpT&?F)*^QvNHqa#DKm)kpik^`hSao
zhnbOqNq|`Z$i4k|qgJQSY^7RPO;tmtXl)&Spgw5<2B2?|buzOsGBL0U3j#HB0F7j1
zWtzKPcDl3NYx6=m&d6hvHNQD3_z1aJ-I%oEmEkqHN`qgM4#ijkjS>+=HU{KM1F#v)
zjEwe-{vbCBqPvk%fdQ<938bW*_df$rm68AhF#Ldyg8LKb13_jXMMGgnfk36gjZlZN
z*)y#yG-QeXvF?ez^Ad^g@xI4Yz673HoAQU}_zt6nRVL}_w{i{FWW3N$m(^O=b4$=B
zS&`3-?cASwpd|`GZ!<G6F|r~o5oAy_bSxA|Y@GPvBh2siihKocUF-Ixu5P*Sp2)c2
zOP2YDpDhgB(n80aH^c`tu4X##p`Jf+dMRV|%`;LzWRECLR1e?4;(NcUb%nU7Uw~5P
z`F@~T;7DKqc}QRuYe)wu+$Dj5h2%w`6eG}4f{I|9K_Mn!?WFc19juZ8$VUlUMnM5Z
zL$FFvzzO6T#Z5{z>^}HC4jh1T0zlP3vk|e%D5z-2;1~$>8!YgEx|SVv4D8~Y!&CLS
zg)4Vkpu5NA)jj8U&#|OmsCc=0-)_IHO)ppe75?1uF!5NDoe6)=6K_3^y|$XHE4m_C
zQaZC%viVFfQ}YS&Su}~&GTfT~^wx(~UaW7kO(V`<*O@4~FrKaG?UQ!xx5Xd--vj{E
Cl+l_1

diff --git a/goldstars/img/platinumwatch.webp b/goldstars/img/platinumwatch.webp
new file mode 100644
index 0000000000000000000000000000000000000000..afc7f79c919f358419f245b24573452bdd5f590f
GIT binary patch
literal 232
zcmV<E02lvKNk&HC00012MM6+kP&gpe0000G1pu7^Djfh506vjGm`SChq9G^>sIU?V
zX#fQf9_WYr%^xYO3Vh{02@f|mPntXc0RH$xXutRR5p5^>PR=l^t7#KuY8WPnbZ`=q
zfy2tZD4E-iNQE%)Iq56`(Q57zstuq&__y*_`$L-ivD6}Aw~xl|=M}Ex%hE|uApLr%
zl!xe7i8QcP*c7#>JDRD_$y8Jpdf-rL(BDd)41UAq%KdPdbK<`-`5w>w`E6Z*Q;B2p
i$s*lDH`3i|0m=|J<bs)mXG{tbyo}Tbd{9T?KmY&&DQRK=

literal 0
HcmV?d00001

diff --git a/goldstars/img/plush_hippo.jpg b/goldstars/img/plush_hippo.jpg
deleted file mode 100644
index c6d00cd0c701741a402bfdd5da83d4180ed398a4..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 878
zcmb7CTS${(7=FM1u+8n?`u^?T!49si>|i=wgwk<a9?FDdc2PIgR?G~8gi$v_EDvd5
zsd<s*jV44`#wsLM7h^Wdl!#KIgBMc9N{WOMf-cs(pFCame&5~uJ<s#L&+{eUCMSXJ
zD=94jLJ0WqK=K0=0?RO|i^bvPRXopeyjrPLs06hjXw({wR;Q<0ov71jsELXO$!IhR
z%gh#&WYJ4TDMdn9#Bh8X&!<URjaK^aN)Cdk0tqCRh`@-16-hD<79hY9SX2s*SE{g+
zo@(G43q=@~13vj41Vk{Dr2yn>U81XS?Qm9Cu;byGtCyq!-wj6-qE}JCje%W2vmD`p
z(JKrRGN_Q4@J#r}RG;r@a7XBKJaaa?F&f^V+tZ+)ymx1h6FICnC*hD~z6b+U)Z19j
z?%XW1;Djzx7Kn_59F5ziclG)Xoa-?;OBLo#A2%Yya%5PH$ANJ!(d(DNObV=z9js|@
z8p6k!*aB9`FRYAmtf)8GP|d?pufIL^Z*+x==?p|lEaRSN=OeE%BU<zAz9FYyupcV!
zioUY8^*^U&jzGM?o;fRMzZbC2nxSe9N@S#5A&V3Mv#@!n)7ul9nX|=Z+goox8m#oU
zr9Ft9Jn=$TyY=$)%ZbtK;%kYsqpcx6lowR~zA#WHRCL$P)T`X?a)ip6$bQrOos}*W
zOBXS|B?+RKlX_&GlyNl7=dC-k`|k9}pnFU?(eWgwIx3rn=`Q&b1Vn1{cx7P9G-?_*
zRI2D>$IXbc9e%bVXeE`UkajLCBHF;|@%qot??sPQ>%uLAr?uT<?ppz4bKj}*)yMrs
zRYkqv`PCR1s=fGS>iU~N?v<=O--`7O=1=8`e08(CVnZTfR^M)kXKXoa`ZN1_*a~!e
G^4(wkzs)}Y

diff --git a/goldstars/img/plush_hippo.webp b/goldstars/img/plush_hippo.webp
new file mode 100644
index 0000000000000000000000000000000000000000..da5b766d331e429acbe5d0aed6654c7932c5a483
GIT binary patch
literal 204
zcmV;-05ktmNk&G*00012MM6+kP&gpC0000G1pu7^Dii<|06vjGmr13gp`j=WsIU?V
zKpC1bZ4Cx!y%vl+jump%jg4nopE^B&0RH=`cMVsRw1YTaIi1PyLdZ^7nBJ_Yh}OuR
zbhy?rtJ$B5_BUjF=bHGgy@9SRSp831Pjd!5ve6LE*nAvXI#!kRFFdm1D{wMXGgizM
zgz;?RtF(3o#2s*#VZd;qv>p{pD6170E3J=1@M=F`PAJHk8$p@@7u=bXRK@S&uPnfL
G#Q*?FW>?n$

literal 0
HcmV?d00001

diff --git a/goldstars/img/silverstar.png b/goldstars/img/silverstar.png
deleted file mode 100644
index 11eac2a0e553b70ce29fdf95055d66a0ff1f1ebb..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1055
zcmV+)1mOFLP)<h;3K|Lk000e1NJLTq000vJ000vR1^@s6a!@wR00006VoOIv0RI60
z0RN!9r;`8x010qNS#tmY3ljhU3ljkVnw%H_000McNliru-v|>71_JCZh$H|21FT6z
zK~y-)os-RLR96_re|PS=GntI!CfspGibP|g5)!D`UFknip#>KSBw1wBE?kv@t1g5P
z3eqmxMHi*}QB0QIyAgsy6Uibvqct(}6*BkYIGL||&)jp43u%a8O6jvX@N$07`|zIk
zz$x0>+XJ9dsobnqtAAB0m74&&ySw}^?eFh<^?E%B!_ZW#)ke8o9{#uciH{YZKYtED
z6h(hzG8wPcYLQN-&-Qw~Re)l#_)#<Kv@YA*+mqRBwkU)UzV8!75o2Rx^3kJ5L(9v{
z=07I`&|3eL$z+65ikX=i+U+*BZ9CVlUHkbo#sYZq<cS@I;bbzI^n?(XZQGv6X0zW(
zDaZ2pJVFSX%_du0TTD++x4PZ#FL4~d(ptZa<G49JJ^i=qy4u><*jN!leC>IjE2SJ(
zN}Wx-7ehls<Z?N}FvPMfN~IEqhldOg50grzR63pZlgVVS)9D;(t=FwmsiZy6vj&3!
z#=IYeWm(v^jpH~drBF%{$1#aSf_A%2v)QE6>G0;w8_t|L!^MjiX}8-Z(P%W@cDr3l
zr4q&%GMNm?WD<Zd42hx$DJA`WpKiB{5Q1DT$K>QBv$M0je*GFLB}Yd`z6gR~q2KTS
z=6T-KvuDr9<#J@RS)`O`t<hRzj3JKW<5LJhtyZJaXmIuFRjSqMt2mCAEr16P9$a@E
z=g&)*E`4%%c*w}e2%hH=$1!mnqm*JW7@)PrvMd^n2EOkzH8q9r`*p4LS95c7Th`jz
z8uRn>+`oVS(=ZG-CMG6^_xAQUfBrl|2mp*R7-O(33#~QvdY$p{arXE3dyeCLzPPx!
zy}rIqVt#&}LZQII!os%J`iCG05JDiOq}S`Al)@N;)|xO3k6+gJeUwt)E-o%^7YYUD
z=H?IpOG`@tNGbD5DWWLCwryP3C7n*w?RLpzGW2>qTCEmRN^ILE48z<>UYy+ED2lEt
zrO;ZF&*uq(fTvHNqP0c{!IdjlICt(Gl}ZI;3{uK3fnWdOKQQa}`(L=OOQ+M}@#DuB
zW4LhP0;yDrD2gZ+i^n@SIyy?ZT>k7N|ACo#FGfa2a2y9A1iQPtJ3$b<%x1Hf$H&KK
z;y7k77yzJ@N}c-AEz3%}u1g}3;Nalk#pdSbty-;iV`XLKX02AcvAMZ<>)_zvg%ASQ
zbpev6CX1rz-ou9vmu%bqK8m8k>gwuSfZMlkbNBAuGVuGIJ9pNa&E_{dJ3BubWA2^g
Z-vON4{f4u_I*$MV002ovPDHLkV1j@h0(JlZ

diff --git a/goldstars/img/silverstar.webp b/goldstars/img/silverstar.webp
new file mode 100644
index 0000000000000000000000000000000000000000..dbf97143546f3fbaf90d6a0b6be777701388ff62
GIT binary patch
literal 174
zcmV;f08#%^Nk&Gd00012MM6+kP&go(0000G1pu7^DiZ(`06vjEm`SChA|WUWsIU?V
zX#fM`NeScVLY+;@MI(Wf0YH}l2MERh0RH=_LcB{g!57hg(-73lHP}$)l?NO~Qkkdh
z3Hd}RTFkLPcB^i>8mC7?^a)_NA+eQuJFOJkv7_K=Hu(`y<D?tg0+{60>ATi#35hhf
c>XnOcmR7%BpY@G7Ij4RGk~-6Fq+QSe08=AKFaQ7m

literal 0
HcmV?d00001

diff --git a/goldstars/src/award_types.csv b/goldstars/src/award_types.csv
index cdde4c416e99..b6babfdfb529 100644
--- a/goldstars/src/award_types.csv
+++ b/goldstars/src/award_types.csv
@@ -4,10 +4,10 @@
 # to be an entry for each type of award given in awards.csv.
 
 Name,Image,Alt,Default Count,Field Order
-Gold star,img/goldstar.png,*,1,1
-Plush hippo,img/plush_hippo.jpg,@,0,2
-Gold watch,img/goldwatch.png,$,0,3
-Platinum watch,img/platinumwatch.jpg,$$,0,4
-Silver star,img/silverstar.png,*,0,5
-Stinkbomb,img/dungbomb.png,&amp;,0,6
-Pink plush watch,img/pinkwatch.jpg,&num;,0,7
+Gold star,img/goldstar.webp,*,1,1
+Plush hippo,img/plush_hippo.webp,@,0,2
+Gold watch,img/goldwatch.webp,$,0,3
+Platinum watch,img/platinumwatch.webp,$$,0,4
+Silver star,img/silverstar.webp,*,0,5
+Stinkbomb,img/dungbomb.webp,&amp;,0,6
+Pink plush watch,img/pinkwatch.webp,&num;,0,7

--------------2.34.1--


