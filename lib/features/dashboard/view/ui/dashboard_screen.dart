import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:neo_admin/features/dashboard/bloc/dashboard_event.dart';
import 'package:neo_admin/features/dashboard/bloc/dashboard_state.dart';
import 'package:neo_admin/features/dashboard/view/widget/data_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the fetch event when the screen is built
    context.read<DashboardBloc>().add(FetchDashboardData());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(text: 'Beranda'),
              const SizedBox(height: 24.0),
              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is DashboardLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DashboardError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is DashboardLoaded) {
                    return _buildResponsiveDashboard(context, state);
                  }
                  // Initial state
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveDashboard(
      BuildContext context, DashboardLoaded state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the available width for responsive design
        final availableWidth = constraints.maxWidth;

        // Define breakpoints for different screen sizes
        // Extra small: < 576px (mobile)
        // Small: >= 576px (mobile landscape)
        // Medium: >= 768px (tablet)
        // Large: >= 992px (desktop)
        // Extra large: >= 1200px (large desktop)

        if (availableWidth >= 1200) {
          // Extra large screens - Original layout (4 cards top, 2 cards bottom)
          return _buildExtraLargeLayout(context, state, availableWidth);
        } else if (availableWidth >= 992) {
          // Large screens - 2x2 grid for top cards, 2 cards bottom
          return _buildLargeLayout(context, state, availableWidth);
        } else if (availableWidth >= 768) {
          // Medium screens - 2x2 grid for top cards, stack bottom cards
          return _buildMediumLayout(context, state, availableWidth);
        } else {
          // Small and extra small screens - Stack all cards vertically
          return _buildSmallLayout(context, state, availableWidth);
        }
      },
    );
  }

  // Extra large screens (≥1200px) - Original layout
  Widget _buildExtraLargeLayout(
      BuildContext context, DashboardLoaded state, double width) {
    // Calculate card sizes
    final cardPadding = 8.0; // Padding between cards
    final topCardWidth = (width - (cardPadding * 8)) / 4; // 4 equal cards
    final bottomLargeCardWidth = width * 0.75 - (cardPadding * 4); // 75% width
    final bottomSmallCardWidth = width * 0.25 - (cardPadding * 4); // 25% width

    return Column(
      children: [
        // Top row with 4 cards
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCard(state.data.bannerCount.toString(), 'Jumlah Banner',
                  topCardWidth, 180),
              _buildCard(state.data.categoryCount.toString(), 'Jumlah Kategori',
                  topCardWidth, 180),
              _buildCard(state.data.brandCount.toString(), 'Jumlah Merek',
                  topCardWidth, 180),
              _buildCard(state.data.productCount.toString(), 'Jumlah Produk',
                  topCardWidth, 180),
            ],
          ),
        ),

        // Bottom row with 2 cards
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCard(state.data.orderCount.toString(), 'Jumlah Pesanan',
                bottomLargeCardWidth, 450),
            _buildCard(state.data.customerCount.toString(), 'Jumlah Customer',
                bottomSmallCardWidth, 450),
          ],
        ),
      ],
    );
  }

  // Large screens (≥992px) - 2x2 grid for top, 2 cards bottom
  Widget _buildLargeLayout(
      BuildContext context, DashboardLoaded state, double width) {
    final cardPadding = 8.0;
    final topCardWidth = (width - (cardPadding * 4)) / 2; // 2 cards per row
    final bottomLargeCardWidth = width * 0.65 - (cardPadding * 4); // 65% width
    final bottomSmallCardWidth = width * 0.35 - (cardPadding * 4); // 35% width

    return Column(
      children: [
        // Top cards in 2x2 grid
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCard(state.data.bannerCount.toString(), 'Jumlah Banner',
                      topCardWidth, 180),
                  _buildCard(state.data.categoryCount.toString(),
                      'Jumlah Kategori', topCardWidth, 180),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCard(state.data.brandCount.toString(), 'Jumlah Merek',
                      topCardWidth, 180),
                  _buildCard(state.data.productCount.toString(),
                      'Jumlah Produk', topCardWidth, 180),
                ],
              ),
            ],
          ),
        ),

        // Bottom row with 2 cards
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCard(state.data.orderCount.toString(), 'Jumlah Pesanan',
                bottomLargeCardWidth, 400),
            _buildCard(state.data.customerCount.toString(), 'Jumlah Customer',
                bottomSmallCardWidth, 400),
          ],
        ),
      ],
    );
  }

  // Medium screens (≥768px) - 2x2 grid for top, stacked bottom
  Widget _buildMediumLayout(
      BuildContext context, DashboardLoaded state, double width) {
    final cardPadding = 8.0;
    final topCardWidth = (width - (cardPadding * 4)) / 2; // 2 cards per row
    final bottomCardWidth = width - (cardPadding * 2); // Full width

    return Column(
      children: [
        // Top cards in 2x2 grid
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCard(state.data.bannerCount.toString(), 'Jumlah Banner',
                      topCardWidth, 160),
                  _buildCard(state.data.categoryCount.toString(),
                      'Jumlah Kategori', topCardWidth, 160),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCard(state.data.brandCount.toString(), 'Jumlah Merek',
                      topCardWidth, 160),
                  _buildCard(state.data.productCount.toString(),
                      'Jumlah Produk', topCardWidth, 160),
                ],
              ),
            ],
          ),
        ),

        // Bottom cards stacked
        _buildCard(state.data.orderCount.toString(), 'Jumlah Pesanan',
            bottomCardWidth, 300),
        _buildCard(state.data.customerCount.toString(), 'Jumlah Customer',
            bottomCardWidth, 300),
      ],
    );
  }

  // Small screens (<768px) - All cards stacked vertically
  Widget _buildSmallLayout(
      BuildContext context, DashboardLoaded state, double width) {
    final cardPadding = 8.0;
    final cardWidth = width - (cardPadding * 2); // Full width

    return Column(
      children: [
        _buildCard(
            state.data.bannerCount.toString(), 'Jumlah Banner', cardWidth, 140),
        _buildCard(state.data.categoryCount.toString(), 'Jumlah Kategori',
            cardWidth, 140),
        _buildCard(
            state.data.brandCount.toString(), 'Jumlah Merek', cardWidth, 140),
        _buildCard(state.data.productCount.toString(), 'Jumlah Produk',
            cardWidth, 140),
        _buildCard(
            state.data.orderCount.toString(), 'Jumlah Pesanan', cardWidth, 250),
        _buildCard(state.data.customerCount.toString(), 'Jumlah Customer',
            cardWidth, 250),
      ],
    );
  }

  // Helper method to build a consistent card
  Widget _buildCard(String data, String label, double width, double height) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DataCard(
        data: data,
        label: label,
        width: width,
        height: height,
      ),
    );
  }
}
