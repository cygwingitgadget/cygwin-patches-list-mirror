Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by sourceware.org (Postfix) with ESMTPS id B7A51399C004
 for <cygwin-patches@cygwin.com>; Fri, 12 Mar 2021 15:11:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B7A51399C004
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.201.226] ([89.1.215.248]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1m0Qyo2vqy-00kQpq for
 <cygwin-patches@cygwin.com>; Fri, 12 Mar 2021 16:11:38 +0100
Date: Fri, 12 Mar 2021 16:11:36 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] Handle "app execution aliases"
Message-ID: <nycvar.QRO.7.76.6.2103121606540.50@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZFZtOBO3vWj8xD+0Q2MS1gvO4ScPn8oLDP4p9FTBcGEloEinRC2
 3Tp4Bm9Ax19CALgL+C2jsEPpyzMO0kC9e5P7d4eX7csw5fGboFG8tje3kJ9ESz1KNmBdHIn
 gRsXQ0ISJccC8bFGs89K5+9V0Bn2G5FM49TMOKVAlM+NUARXupA3btyMBZLQubNTouO2oII
 KcgjcoXWDEkRtV4FQdVig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g27EdPjUpiU=:p/wDmzPrB9TalgFSIW/Ux7
 q6JZjfhYQzGjPnpD6BdXuBJY399SIOVmqb4aqLpBUhMRranHM5gw9xyzntVTFEZvZVZNaLvFF
 ruD9gklVKTvSBD9agBed3j83l4GJrmVZ7JEkjfSSHgWBC6wXcuB1uLFi+43mIY/xCgVrSHEVr
 H5TxWHuWeji63KOZ5MPCn0Ycbxz27VOOOY6PI+ycl6UdaEot1HG3crWwOez6zugrORZJRSF2f
 RpSdgVNDjHxJepVa+uV27lmyO/4RvrYhPoW/v2eMKsWzbIC051GIOPG/cUIeQiGPj9MSMZwgw
 DP+l5iNXISqxLr7k09Hyv94lb9rsfkntLT4YQdP4etiGc4IWiPTMaoetI+Zvm9gQzBYxXlGjn
 llcujQSuqgazQFA4zG6fLglq/7EhzQg9s/vmoUZ+caeGwjQR2cOZeWHfXRnGxWlL4QT7R2e6q
 8QGdCo+Kg9zqviAjCcdIopPTb8Al0FobIXR2DpgCvAu+s1rvRKC9fvpwaFiBf/i2Zk5oiHDos
 tSDBR+P40XJKQbwQbeyLWG6PRfWo6RGIa6QSYhoMKu0huBiOYn5LaR8l1Xoaxx04b7ZK/cr6l
 o00u/jfiIcyDZuznkar8DWmPKKQiTqQQIawjfLm1uzQu6VqC7rqe1tkATlWCSm/9hS+cGeLmO
 mL7p0F2DEF/GExa+BuV1lH+hnAbpWEKctsQ8SeF0QwUx7VeC3hwA7yDHs8OU4GzB+v7nqSCKu
 iayyF1On5UheQn8CD6eui0pQH4nsoNxFYQBQnNVdfwf9Wq1NULbTrAe2FYvJFozdzBcbJL+hE
 duPGX299JOPbiYYAW7kzWORFUMuSUs5iW4seDaE/hVI5u0xR4oQx/keGUtPPsEaBQuAAurUGM
 LCg5oJ3hC5xlRVPvAVIhnnyoEwfoxfj8VSMz/icJ8=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 12 Mar 2021 15:11:42 -0000

When installing e.g. Python via the Windows Store, it is common that the
`python3.exe` entry in the `PATH` is not actually an executable at all,
but an "app executaion alias" (i.e. a special class of reparse point).

These filesystem entries are presented as 0-size files, but they are not
readable, which is why Cygwin has problems to execute them, with the error
message "Permission denied".

This issue has been reported a couple of times in the Git for Windows and
in the MSYS2 project, and even in Cygwin
(https://cygwin.com/pipermail/cygwin/2020-May/244969.html, the thread
devolved into a discussion about Thunderbird vs Outlook before long,
though).

The second patch fixes that, and for good measure, the first patch teaches
Cygwin to treat these reparse points as symbolic links.

Johannes Schindelin (2):
  Treat Windows Store's "app execution aliases" as symbolic links
  Allow executing Windows Store's "app execution aliases"

 winsup/cygwin/path.cc  | 24 ++++++++++++++++++++++++
 winsup/cygwin/spawn.cc |  7 +++++++
 2 files changed, 31 insertions(+)

=2D-
2.30.2

