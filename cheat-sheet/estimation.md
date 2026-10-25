# Estimation cheat sheet

Say the formula out loud first, then plug in rounded numbers. Examples use 100M DAU.

## Formulas

### Traffic
| Metric | Formula | Example |
|---|---|---|
| **Average QPS** | DAU × actions per user per day ÷ 10⁵ | 100M × 10 ÷ 10⁵ = 10K QPS |
| Peak QPS | average QPS × 2–3 (×5 for spiky events) | 10K × 3 = 30K QPS |
| Read QPS | write QPS × read:write ratio | 1K writes × 100 = 100K reads/s |
| Requests per day | QPS × 86,400 (≈ 10⁵) | 1K QPS ≈ 86M per day |
| Fan-out deliveries | writes/s × average followers or recipients | 1K posts/s × 200 = 200K/s |
| Concurrent connections | DAU × fraction online at peak (or QPS × request duration) | 100M × 10% = 10M sockets |

### Storage
| Metric | Formula | Example |
|---|---|---|
| Storage per day | new items per day × size per item | 100M × 500 B = 50 GB/day |
| **Total storage** | per day × 365 × years × replicas (3) | 50 GB × 365 × 5 × 3 ≈ 270 TB |
| Media storage | uploads per day × average file size | 10M photos × 300 KB = 3 TB/day |
| Video size | bitrate × duration ÷ 8 | 5 Mbps × 60 s ÷ 8 ≈ 40 MB |

### Bandwidth
| Metric | Formula | Example |
|---|---|---|
| Ingress (in) | write QPS × request size | 1K/s × 300 KB = 300 MB/s |
| **Egress (out)** | read QPS × response size | 100K/s × 500 B = 50 MB/s |
| In bits | bytes per second × 8 | 50 MB/s = 400 Mbps |

### Memory and machines
| Metric | Formula | Example |
|---|---|---|
| **Cache size** | 0.2 × reads per day × object size (80/20 rule) | 0.2 × 1B × 500 B = 100 GB |
| Cache nodes | cache size ÷ usable RAM per node (~100 GB) | 100 GB ÷ 100 GB = 1, use 2–3 |
| App servers | peak QPS ÷ (QPS per server × 0.7), then add headroom | 30K ÷ (5K × 0.7) ≈ 9 → 12 |
| Database shards | max(total data ÷ data per shard, write QPS ÷ writes per shard) | max(270 TB ÷ 5 TB, 1K ÷ 5K) = 54 |
| Queue partitions | throughput ÷ throughput per partition (~10 MB/s) | 300 MB/s ÷ 10 MB/s = 30 |

### IDs
| Metric | Formula | Example |
|---|---|---|
| ID space | alphabet size ^ length | 62⁷ ≈ 3.5 × 10¹² |
| Years until IDs run out | ID space ÷ (IDs per day × 365) | 3.5 × 10¹² ÷ (100M × 365) ≈ 96 years |
| Characters needed | log₆₂(total IDs), rounded up | log₆₂(3.65 × 10¹¹) ≈ 6.5 → 7 |

## Numbers to know

| Time | |
|---|---|
| Seconds in a day | **86,400 ≈ 10⁵** |
| Seconds in a month | ≈ 2.6 × 10⁶ |
| Seconds in a year | **≈ 3 × 10⁷** |

| Per day → per second | |
|---|---|
| 1M per day | ≈ 12 /s |
| 100M per day | **≈ 1.2K /s** |
| 1B per day | ≈ 12K /s |

| Sizes | |
|---|---|
| ASCII char / int64 / UUID | 1 B / 8 B / 16 B |
| Short post or chat message + metadata | 200–500 B |
| Database metadata row | **~500 B – 1 KB** |
| Thumbnail / compressed photo | ~20 KB / 200 KB – 2 MB |
| 1 min of 1080p video | ~50 MB |

| What one box can do | |
|---|---|
| Stateless app server | 1K–10K QPS |
| Redis node | ~100K ops/s |
| SQL primary, writes | ~1K–10K /s |
| Cache node usable RAM | ~64–256 GB |
| 10 Gbps network card | ≈ 1.25 GB/s |

| Latency | |
|---|---|
| Main memory read | ~100 ns |
| SSD random read | ~100 µs |
| Round trip, same data center | ~0.5 ms |
| Disk seek | ~10 ms |
| Round trip, across continents | ~150 ms |

## The recipe

1. Write the formula in words before any number.
2. Anchor time: 1 day ≈ 10⁵ s.
3. Carry the unit on every line.
4. Round to one significant figure.
5. Say what the number means: "about 1K QPS, so one database is fine."
